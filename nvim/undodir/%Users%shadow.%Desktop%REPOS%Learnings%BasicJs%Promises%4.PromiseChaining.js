Vim�UnDo� Q�]`�"���eW���`�OO��WsA�9   ;                                  g8Ӕ   	 _�                             ����                                                                                                                                                                                                                                                                                                                                                             g8�W    �   &              4    throw new Error("Manual error after Operation 2"�   '            �                   �               5��                    &   4                   �      �    &   4                 �              ~      5�_�                    "       ����                                                                                                                                                                                                                                                                                                                                                             g8�]     �   !   $   ;          return asyncOperation2();5��    !                    H                     �    "                     M                     5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                             g8�f     �   "   $   <          console.log5��    "                     X                     5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                             g8�h     �   "   $   <          console.log()5��    "                     Y                     5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                             g8Ѡ     �   "   $   <          console.log(response)5��    "                     Y                     5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                             g8ѡ     �   "   $   <          console.log()5��    "                     Y                     5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                             g8��     �   "   $   <          console.log(resolve)5��    "                     Y                     5�_�      	              #       ����                                                                                                                                                                                                                                                                                                                                                             g8��     �   "   $   <          console.log()5��    "                     Y                     5�_�      
           	   #       ����                                                                                                                                                                                                                                                                                                                                                             g8��    �   "   $   <          console.log(response)5��    "                     b                     5�_�   	              
   #       ����                                                                                                                                                                                                                                                                                                                                                             g8�9     �   "   $   <          console.log(response);5��    "                     Y                     5�_�   
                 #       ����                                                                                                                                                                                                                                                                                                                                                             g8�:    �   "   $   <          console.log();5��    "                     Y                     5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                             g8�f     �   "   #              console.log(result2);5��    "                      I                     5�_�                    $       ����                                                                                                                                                                                                                                                                                                                                                             g8�h     �   #   &   ;        .then((result2) => {5��    #                    d                     �    $                     e                    �    $                     f                     �    $                      e                     5�_�                    %        ����                                                                                                                                                                                                                                                                                                                                                             g8�h     �   %   '   <    �   %   &   <    5��    %                      f                     5�_�                    &       ����                                                                                                                                                                                                                                                                                                                                                             g8�k    �   $   &   =              console.log(result2);5��    $                      e                     5�_�                    %       ����                                                                                                                                                                                                                                                                                                                                                             g8�o     �   $   %              console.log(result2);5��    $                      e                     5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                             g8�p     �   "   %   ;        })5��    "                    M                     �    #                     O                     �    #                      N                     5�_�                    $        ����                                                                                                                                                                                                                                                                                                                                                             g8�q     �   $   &   <    �   $   %   <    5��    $                      O                     5�_�                    $        ����                                                                                                                                                                                                                                                                                                                                                             g8�s     �   "   $   =        })    �   #   %   =       5��    "                     M                     5�_�                    $       ����                                                                                                                                                                                                                                                                                                                            %          <          v       g8ӓ   	 �   #   $              console.log(result2);5��    #                      N                     5�_�                   <       ����                                                                                                                                                                                                                                                                                                                            %          <          v       g8ҍ     �   $   =            // .then((result2) => {   5  //   console.log("Second then received:", result2);   .  //   // Throw an error to simulate a failure   9  //   throw new Error("Manual error after Operation 2");     // })     // .then((result3) => {   a  //   console.log("Third then received:", result3); // This will be skipped because of the error     // })     // .catch((error) => {   .  //   console.log("Caught in catch:", error);   <  //   // Recovery: return a new value to continue the chain   %  //   return "Recovered from error";     // })      // .then((recoveredValue) => {   :  //   console.log("Resumed chain with:", recoveredValue);   6  //   // Intentionally call a failing async operation   (  //   return asyncOperationWithError();     // })     // .catch((error) => {   ;  //   console.log("Caught second error in catch:", error);     // })     // .finally(() => {   8  //   console.log("All done (clean-up or final log).");     // });5��    $                     h      )      q      5�_�                    ;       ����                                                                                                                                                                                                                                                                                                                                                v       g8ґ    �      =          %asyncOperation1().then((result1) => {   /  console.log("First then received:", result1);   ,  // Pass value directly to the next .then()     return asyncOperation2();   });   console.log(result2);   // .then((result2) => {   3//   console.log("Second then received:", result2);   ,//   // Throw an error to simulate a failure   7//   throw new Error("Manual error after Operation 2");   // })   // .then((result3) => {   _//   console.log("Third then received:", result3); // This will be skipped because of the error   // })   // .catch((error) => {   ,//   console.log("Caught in catch:", error);   ://   // Recovery: return a new value to continue the chain   #//   return "Recovered from error";   // })   // .then((recoveredValue) => {   8//   console.log("Resumed chain with:", recoveredValue);   4//   // Intentionally call a failing async operation   &//   return asyncOperationWithError();   // })   // .catch((error) => {   9//   console.log("Caught second error in catch:", error);   // })   // .finally(() => {   6//   console.log("All done (clean-up or final log).");   // });5��                       �             �      5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                v       g8Ҥ     �   "   $   ;      console.log();5��    "                     P                     5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                v       g8ҥ     �   "   $   ;      console.log();5��    "                     Q                     �    "                     Q                     5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                v       g8ҧ     �   "   $   ;      console.log(asyncOperation2);5��    "                     P                     �    "                    R                    �    "                    Q                    �    "                    P                    �    "                    P                    �    "                     ^                     �    "                     ]                     �    "                     \                     �    "                     [                     �    "                     Z                     �    "                     Y                     �    "                     X                     �    "                     W                     �    "                     V                     �    "                     U                     �    "                     T                     �    "                     S                     �    "                     R                     �    "                     Q                     �    "                    P                    �    "                    P                    �    "                    P                    5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                v       g8ҫ     �   "   $   ;      console.log(asyncOperation2());5��    "                     _                     5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                v       g8ҭ    �   "   $   ;      %console.log(asyncOperation2(result));5��    "                     `                     5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                v       g8Һ     �   "   $   ;      console.log(asyncOperation2());5��    "                     `                     5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                v       g8һ    �   "   $   ;      'console.log(asyncOperation2(response));5��    "                     `                     5�_�                     #       ����                                                                                                                                                                                                                                                                                                                                       #          v���    g8��    �   "   $   ;      console.log(asyncOperation2());5��    "                     `                     5��