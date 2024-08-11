import React, { useState, useEffect } from "react";

function TyingSpeedFeedback({ text, startTime, typingSpeed, setTypingSpeed }) {
  // const [text, setText] = useState("");
  // const [startTime, setStartTime] = useState(null);
  // const [typingSpeed, setTypingSpeed] = useState(null);

  // const handleInputChange = event => {
  //   const inputValue = event.target.value;
  //   setText(inputValue);

  //   if (!startTime) {
  //     // Start measuring typing speed when the user starts typing
  //     setStartTime(new Date());
  //   }
  // };

  useEffect(() => {
    if (startTime) {
      const endTime = new Date();
      const elapsedTimeInSeconds = (endTime - startTime) / 1000;
      const wordsTyped = text.split(/\s+/).filter(Boolean).length;
      const wordsPerMinute = (wordsTyped / elapsedTimeInSeconds) * 60;

      setTypingSpeed(wordsPerMinute);
    }
  }, [text, startTime]);

  const getBackgroundColor = () => {
    if (typingSpeed < 10) {
      return "gray";
    } else if (typingSpeed >= 10 && typingSpeed < 20) {
      return "orange";
    } else {
      return "red";
    }
  };

  return (
    <div className="bg-gray-800 " style={{ backgroundColor: getBackgroundColor(), padding: "20px" }}>
      {/* <textarea
        placeholder="Start typing here..."
        value={text}
        onChange={handleInputChange}
        style={{ width: "100%", minHeight: "100px" }}
      /> */}
      <p className="pt-20">
        Typing Speed: {typingSpeed !== null ? `${typingSpeed.toFixed(2)} words per minute` : "Calculating..."}
      </p>
    </div>
  );
}

export default TyingSpeedFeedback;
