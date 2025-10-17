const HomeCards = ({ title, description, image }) => {
  return (
    <div className="h-[530px] backdrop-blur-xl  bg-black/2 rounded-2xl  transition-transform duration-300 transform hover:scale-110 hover:shadow-xl flex flex-col justify-between shadow-glass hover:shadow-glass-pressed w-[350px]">
      <img
        src={image}
        alt={title}
        className=" object-cover transition-transform duration-300 transform group-hover:scale-125  w-full overflow-hidden rounded-xl  shadow-glass hover:shadow-glass-pressed max-h-[350px] content-stretch  min-h-[62%] h-[62%]"
      />
      {/* Text Content */}
      <p className="text-3xl m-0 p-0 font-semibold capitalize  bg-gradient-to-r from-purple-600 via-blue-500 to-cyan-400 bg-clip-text text-transparent text-center font-orbitron  min-h-[6%] h-[6%]">
        {title.toUpperCase()}
      </p>
      <div>
        {description && (
          <div className="min-h-[32%] h-[32%]">
            <p className="text-gray-200 text-lg overflow-hidden px-4 line-clamp-5 mb-2">
              {description}
            </p>
          </div>
        )}
      </div>
    </div>
  );
};

export default HomeCards;