import { Link } from "react-router-dom";
import { useState, useEffect } from "react";
import { useClerk } from "@clerk/clerk-react";
import logo from "../assets/logo.svg";
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

const Navbar = () => {
  const { user, signOut, isSignedIn } = useClerk();
  const [isCollapsed, setIsCollapsed] = useState(true);

  const toggleNavbar = () => {
    setIsCollapsed(!isCollapsed);
  };

  const handleLogout = async () => {
    console.log("Logging out...");
    await signOut();
    toast.success("You have logged out successfully!");
  };

  // Add an effect that only triggers the toast after the logout
  useEffect(() => {
    if (!isSignedIn) {
      toast.success("You have logged out successfully!");
    }
  }, [isSignedIn]);

  return (
    <nav className="text-white p-4">
      <div className="backdrop-blur-sm bg-white/8 shadow-glass rounded-4xl container mx-auto   px-4 py-3 flex items-center justify-between ">
        {/* Logo + Brand */}
        <Link to="/" className="flex items-center gap-2">
          <img src={logo} alt="Logo" className="h-7 w-auto " />
          <span className="font-bold text-white text-lg m-0 p-0">
            Game Mentor
          </span>
        </Link>

        {/* Mobile Hamburger Button */}
        <button
          className="md:hidden text-white focus:outline-none flex items-end justify-end"
          onClick={toggleNavbar}
        >
          <svg
            className="w-6 h-6"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d={
                isCollapsed ? "M4 6h16M4 12h16M4 18h16" : "M6 18L18 6M6 6l12 12"
              }
            />
          </svg>
        </button>

        {/* Nav Links */}
        <div
          className={`w-full  md:flex md:items-center md:w-auto ${
            isCollapsed ? "hidden" : "block"
          } mt-4 md:mt-0`}
        >
          <ul className="flex flex-col md:flex-row md:space-x-20 items-center">
            <li>
              <Link to="/" className="hover:text-blue-400">
                Games
              </Link>
            </li>
            <li>
              <Link to="/about" className="hover:text-blue-400">
                Mentors
              </Link>
            </li>
            <li>
              <Link to="/TournamentPage" className="hover:text-blue-400">
                Tournaments
              </Link>
            </li>
            <li>
              <Link to="/community" className="hover:text-blue-400">
                Community
              </Link>
            </li>
          </ul>
        </div>

        <ul>
          {isSignedIn ? (
            <div className=" hidden md:flex  gap-4 items-center">
              <li>
                <span className="font-bold">
                  Welcome, {user.firstName || "User"}!
                </span>
              </li>
              <li>
                <button
                  onClick={handleLogout}
                  className="bg-red-600 hover:bg-red-700 text-white px-3 py-1 rounded"
                >
                  Logout
                </button>
              </li>
            </div>
          ) : (
            <li>
              <Link
                to="/sign-in"
                className="hidden md:flex hover:text-blue-400"
              >
                Login
              </Link>
            </li>
          )}
        </ul>
      </div>

      <ToastContainer />
    </nav>
  );
};
export default Navbar;
