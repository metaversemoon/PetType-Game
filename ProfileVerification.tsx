import React from "react";
import { MdVerified } from "react-icons/md";
import { ImLocation2 } from "react-icons/im";

function ProfileVerification({ getBalance }: any) {
  return (
    <>
      <div className="pt-8 flex justify-between">
        <h1 className="font-bold  text-2xl">Welcome Back </h1>
        <h2 className="font-semibold text-xl ">
          Your balance is: {getBalance?.toString()}
          <span className="text-gray-500">FE</span>
        </h2>
      </div>
      <div className="flex">
        <div className="py-4 px-8 w-[40%]">
          <div className="flex text-center  justify-center">
            <img
              src="https://images.unsplash.com/photo-1601412436009-d964bd02edbc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1364&q=80"
              alt="profile"
              className="w-20 h-20 rounded-full"
            />
            <div className="pl-4">
              <div className="flex justify-center items-center">
                <p className="pr-2 font-bold text-xl">Joe Smith</p>
                <MdVerified size="1.5rem" fill="blue" />
              </div>
              <div className="flex items-center">
                <ImLocation2 size="1.5rem" fill="gray" />
                <p className="my-0 text-custom-base3 ">NYC, USA</p>
              </div>
            </div>
          </div>
        </div>

        <div className="grid grid-cols-5 gap-5 mt-4">
          <div className="col-span-4">
            <img src="/assets/graph1.png/" alt="my graph" />
          </div>
          <div className="col-span-1"></div>
        </div>
      </div>
    </>
  );
}

export default ProfileVerification;
