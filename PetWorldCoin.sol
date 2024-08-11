// SPDX-License-Identifier: MIT
pragma solidity ^ 0.8 .10;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { ByteHasher } from './helpers/ByteHasher.sol';
import { IWorldID } from './interfaces/IWorldID.sol';

contract UserProfile is ERC721URIStorage {

    using ByteHasher
    for bytes;
    using Counters
    for Counters.Counter;
    Counters.Counter public _totalNFTs;
    uint public _totalClasses = 0;
    uint256 constant caloriesNeededPerDayByHour = 120 / 5;


    /// @notice Thrown when attempting to reuse a nullifier
    error InvalidNullifier();
    /// @dev The WorldID instance that will be used for verifying proofs
    // IWorldID internal immutable worldId;
    /// @dev The WorldID group ID (1)
    uint256 internal immutable groupId = 1;
    /// @dev Whether a nullifier hash has been used already. Used to prevent double-signaling
    mapping(uint256 => bool) internal nullifierHashes;

    struct Game {
        uint256 score;
        string day;
    }

    struct Profile {
        address walletAddress;
        string imageName;
        string petName;
        uint256 caloriesGranted;
        uint256 availableCalories;
        uint256 caloriesNeededPerDay;
        mapping(uint256 => Game) gamesPlayed;
        uint256 numberOfGamesPlayed;
        uint256 timeLeft;
    }

    event PetDied(address indexed petOwner, string message);

    mapping(address => Profile) public profiles;


    // calldata is read only, use for funct inputs as params
    // function createClass(string calldata _cid, uint _targetAmmount) public {
    function createGame(string calldata _cid, uint _targetAmmount, address input, uint256 root, uint256 nullifierHash, uint256[8] calldata proof) public {
        // first, we make sure this person hasn't done this before
        if (nullifierHashes[nullifierHash]) revert InvalidNullifier();
        then, we verify they 're registered with WorldID, and the input they'
        ve provided is correct
        worldId.verifyProof(
            root,
            groupId,
            abi.encodePacked(input).hashToField(),
            nullifierHash,
            abi.encodePacked(address(this)).hashToField(),
            proof
        );
        finally, we record they 've done this, so they can'
        t do it again(proof of uniqueness)
        nullifierHashes[nullifierHash] = true;


        listOfClasses[_totalClasses] = ClassesBluePrint(_totalClasses, _cid, _targetAmmount, 0, msg.sender);
        emit GroupCreated(_totalClasses, _cid, _targetAmmount, msg.sender);
        _totalClasses++;
    }

    function createProfile(
        address _walletAddress,
        string memory _imageName,
        string memory _petName
    ) external {
        Profile storage user = profiles[_walletAddress];
        // console.log("address(0)", address(0));
        require(user.walletAddress == address(0), "Profile already exists");

        user.walletAddress = _walletAddress;
        user.imageName = _imageName;
        user.petName = _petName;
        user.caloriesGranted = 60;
        user.availableCalories = 60;
        user.caloriesNeededPerDay = caloriesNeededPerDayByHour;
        user.timeLeft = calculateTimeInSeconds(60); // Assuming starting with 20 calories
    }

    function calculateTimeInSeconds(uint256 currentCalories) internal view returns(uint256) {
        // Assuming a consumption rate of 5 calories per hour
        uint256 caloriesPerHour = 5;

        // Calculate time block in seconds
        uint256 timeBlock = currentCalories / caloriesPerHour * 1 hours;

        return block.timestamp + timeBlock;
    }


    function checkPetLife(address _walletAddress) external {
        Profile storage user = profiles[_walletAddress];
        require(user.walletAddress != address(0), "Profile does not exist");

        if (block.timestamp > user.timeLeft) {
            // Pet has died due to insufficient calories
            emit PetDied(_walletAddress, "Your pet has died due to insufficient calories");
            // Additional actions when the pet dies can be added here
        }
    }

    function numberOfGamesPlayed(address _walletAddress) external view returns(uint256) {
        return profiles[_walletAddress].numberOfGamesPlayed;
    }

    function saveGamePlayed(address _walletAddress, uint256 _score, string memory _day) external returns(Game memory) {
        Profile storage user = profiles[_walletAddress];
        Game memory newGame = Game(_score, _day);
        user.gamesPlayed[user.numberOfGamesPlayed] = newGame;
        user.availableCalories = user.availableCalories + _score;
        user.numberOfGamesPlayed++;

        // Recalculate time left after saving the game
        user.timeLeft = calculateTimeInSeconds(user.availableCalories);

        return newGame;
    }

    function saveScore(address _walletAddress, uint256 _score) external {
        Profile storage user = profiles[_walletAddress];
        // require(user.availableCalories >= _score, "Not enough available calories");

        user.availableCalories -= _score;

        // Recalculate time left after saving the score
        user.timeLeft = calculateTimeInSeconds(user.availableCalories);
    }

    function createFlow(address receiver, int96 flowRate, uint256 toWrap) external {
        _transfer(msg.sender, address(this), toWrap);
        _approve(address(this), superToken, toWrap);
        IAlluoSuperToken(superToken).upgradeTo(msg.sender, toWrap, "");
        cfaV1Lib.createFlowByOperator(msg.sender, receiver, ISuperfluidToken(superToken), flowRate);
        ISuperfluidResolver(superfluidResolver).addToChecker(msg.sender, receiver);
        emit CreateFlow(msg.sender, receiver, flowRate);
    }

    function stopFlowWhenCritical(address sender, address receiver) external onlyRole(DEFAULT_ADMIN_ROLE) {
        cfaV1Lib.deleteFlowByOperator(sender, receiver, ISuperfluidToken(superToken));
        emit DeletedFlow(sender, receiver);
    }

    function forceWrap(address sender) external onlyRole(DEFAULT_ADMIN_ROLE) {
        uint256 balance = balanceOf(address(sender));
        _transfer(sender, address(this), balance);
        _approve(address(this), superToken, balance);
        IAlluoSuperToken(superToken).upgradeTo(sender, balance, "");
    }

}
