import React from "react";
import { upload } from "../assets/images";

export default function Alert({ message, type }) {
  if (type === "error") {
    return (
      <div role="alert" className="border-s-4 border-red-500 bg-red-50 p-4">
        <div className="flex items-center gap-2 text-red-800">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            fill="currentColor"
            className="h-5 w-5 mt-1"
          >
            <path
              fillRule="evenodd"
              d="M9.401 3.003c1.155-2 4.043-2 5.197 0l7.355 12.748c1.154 2-.29 4.5-2.599 4.5H4.645c-2.309 0-3.752-2.5-2.598-4.5L9.4 3.003zM12 8.25a.75.75 0 01.75.75v3.75a.75.75 0 01-1.5 0V9a.75.75 0 01.75-.75zm0 8.25a.75.75 0 100-1.5.75.75 0 000 1.5z"
              clipRule="evenodd"
            />
          </svg>
          <strong className="block font-bold text-xl">Failure</strong>
        </div>
        <p className="mt-2 text-base text-red-700">{message}</p>
      </div>
    );
  } else if (type === "success") {
    return (
      <div role="alert" className="border-s-4 border-green-500 bg-green-50 p-4">
        <div className="flex items-center gap-2 text-green-800">
          <svg
            className="h-5 w-5 fill-[#166534]"
            viewBox="0 0 512 512"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM369 209L241 337c-9.4 9.4-24.6 9.4-33.9 0l-64-64c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L335 175c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z" />
          </svg>
          <strong className="block font-bold text-xl">Success</strong>
        </div>
        <p className="mt-2 text-base text-green-700">{message}</p>
      </div>
    );
  } else if (type === "op") {
    return (
      <div
        role="alert"
        className="border-s-4 border-orange-600 bg-orange-50 p-4"
      >
        <div className="flex items-center gap-2 text-orange-800">
          <img src={upload} alt="upload" className="h-6 w-6" />
          <strong className="block font-bold text-xl">Progress</strong>
        </div>
        <p className="mt-2 text-base text-orange-700">{message}</p>
      </div>
    );
  }
}
