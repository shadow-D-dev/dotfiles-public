Vim�UnDo� u���Gn쪡|�5a��_ɠW�������Np��      &import {Button} from "@repo/ui/button"                              g@�    _�                             ����                                                                                                                                                                                                                                                                                                                                                  v        g@��     �         f      (type Props = Omit<ImageProps, "src"> & {     srcLight: string;     srcDark: string;   };       &const ThemeImage = (props: Props) => {   /  const { srcLight, srcDark, ...rest } = props;       
  return (       <>   =      <Image {...rest} src={srcLight} className="imgLight" />   ;      <Image {...rest} src={srcDark} className="imgDark" />       </>     );   };5��                         �       F              5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  v        g@��     �         X      ;5��                          �                      5�_�                    	        ����                                                                                                                                                                                                                                                                                                                            	           V   
       v���    g@��     �      
   X   O   !    <div className={styles.page}>   $      <main className={styles.main}>           <ThemeImage   !          className={styles.logo}   '          srcLight="turborepo-dark.svg"   '          srcDark="turborepo-light.svg"             alt="Turborepo logo"             width={180}             height={38}             priority   
        />           <ol>             <li>   F            Get started by editing <code>apps/docs/app/page.tsx</code>             </li>   7          <li>Save and see your changes instantly.</li>           </ol>       %        <div className={styles.ctas}>             <a   &            className={styles.primary}  �            href="https://vercel.com/new/clone?demo-description=Learn+to+implement+a+monorepo+with+a+two+Next.js+sites+that+has+installed+three+local+packages.&demo-image=%2F%2Fimages.ctfassets.net%2Fe5382hct74si%2F4K8ZISWAzJ8X1504ca0zmC%2F0b21a1c6246add355e55816278ef54bc%2FBasic.png&demo-title=Monorepo+with+Turborepo&demo-url=https%3A%2F%2Fexamples-basic-web.vercel.sh%2F&from=templates&project-name=Monorepo+with+Turborepo&repository-name=monorepo-turborepo&repository-url=https%3A%2F%2Fgithub.com%2Fvercel%2Fturborepo%2Ftree%2Fmain%2Fexamples%2Fbasic&root-directory=apps%2Fdocs&skippable-integrations=1&teamSlug=vercel&utm_source=create-turbo"               target="_blank"   %            rel="noopener noreferrer"             >               <Image   %              className={styles.logo}                 src="/vercel.svg"   #              alt="Vercel logomark"                 width={20}                 height={20}               />               Deploy now             </a>             <a   ;            href="https://turbo.build/repo/docs?utm_source"               target="_blank"   %            rel="noopener noreferrer"   (            className={styles.secondary}             >               Read our docs             </a>           </div>   <        <Button appName="docs" className={styles.secondary}>             Open alert           </Button>         </main>   (      <footer className={styles.footer}>   
        <a   �          href="https://vercel.com/templates?search=turborepo&utm_source=create-next-app&utm_medium=appdir-template&utm_campaign=create-next-app"             target="_blank"   #          rel="noopener noreferrer"   	        >             <Image               aria-hidden               src="/window.svg"               alt="Window icon"               width={16}               height={16}             />             Examples           </a>   
        <a   <          href="https://turbo.build?utm_source=create-turbo"             target="_blank"   #          rel="noopener noreferrer"   	        >             <Image               aria-hidden               src="/globe.svg"               alt="Globe icon"               width={16}               height={16}             />             Go to turbo.build →           </a>         </footer>   
    </div>     );5��           N               �       �
              5�_�                       
    ����                                                                                                                                                                                                                                                                                                                            	           	   
       v���    g@��     �      
   
      
  return (5��       
                 �                      �                         �                      5�_�                           ����                                                                                                                                                                                                                                                                                                                            
           
   
       v���    g@��     �                 4import Image, { type ImageProps } from "next/image";5��                                   5               5�_�                           ����                                                                                                                                                                                                                                                                                                                            	           	   
       v���    g@��     �                 )import { Button } from "@repo/ui/button";5��                                   *               5�_�                           ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@��     �                 'import styles from "./page.module.css";5��                                   (               5�_�      	                      ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@��     �                     �                5��                                                  5�_�      
           	           ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@��    �                         export default function Home() {�               
  return (     <div>Hello</div>     );5��       	                ,                     �                                                  5�_�   	              
          ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@��     �                 return <div>Hello</div>;5��                         /                      5�_�   
                        ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@��     �                 return <div>�                	  </div>;�                 return <div></div>;5��                        /                      �                        /                      �                         0                     �                         6                      �                        5                     �                        ;                     5�_�                            ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@��     �                 export default function Home() {5��                                                  5�_�                            ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@��     �                 5��                                                  5�_�                           ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@��     �                import 5��                                                5�_�                           ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@��     �                	import {}5��                                                5�_�                           ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@��     �                import {Button}5��                                                5�_�                           ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@��     �                import {Button} from 5��                                                5�_�                           ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@��     �                import {Button} from ""5��                                                �                                              �                                              �                                              �                                              �                                              �                                              �                                              �                                              �                                              5�_�                           ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@��     �                   <Button/>5��                         b                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@��     �                   <Button />5��                         b                      �                        c                     �                        c                     �                        c                     �                        c                     �                        c                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@��     �                   <Button appName="webapp" />5��                         q                      �                         p                      �                         o                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@�     �                   <Button appName="web" />5��                         r                      �                         q                      �                        p                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@�     �                   <Button appName="web">5��                         q                      �                     	   v              	       �       '                  ~                      �       &                  }                      �       %                  |                      �       $                  {                      �       #                  z                      �       "                  y                      �       !                 x                     �       !                 x                     5�_�                            ����                                                                                                                                                                                                                                                                                                                                          
       v���    g@�    �                &import {Button} from "@repo/ui/button"�                 return <div>   (    <Button appName="web">Hello</Button>   	  </div>;5��       	               Q       7       E       �                      !                 !       5��