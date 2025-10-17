import AddIcon from "@/../public/WhitePlusIcon.svg";
import Image from "next/image";
interface PlusButtonProps {
  text: string;
}
export default function PlusButton({ text }: PlusButtonProps) {
  return (
    <div className="xs:flex-col flex  justify-center items-center gap-2 bg-[#5e5eee] rounded-full p-4 text-white text-md font-plusJakarta font-bold ">
      <p>{text}</p>
      <Image src={AddIcon} alt="plus icon" className="h-4 w-4" />
    </div>
  );
}

const functions shadow=()={
  console.log("shadow")
}