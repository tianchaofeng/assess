package assess;

import java.io.BufferedReader;  
import java.io.BufferedWriter;  
import java.io.File;  
import java.io.FileInputStream;  
import java.io.FileOutputStream;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.io.OutputStreamWriter;  
 
/**
 * 统计代码行数
 * */
public class CodeStatics {  
    /** 
     * @author lishengfei 
     * @date 2014-12-1 17:49:52 
     * @CopyRight zzjskj 
     */  
      
    /** 
     * 定义两个全局变量，生命周期是整个类 
     *  
     */  
    public static int sumFile = 0;// 总文件数  
    public static int sumLine = 0;// 总行数  
  
    public CodeStatics() {  
        // TODO Auto-generated constructor stub  
    }  
  
    /** 
     * 统计代码行数 
     *  
     * @param inFile 
     *            输入的文件，包含子文件和子文件夹 
     * @param bw 
     *            缓冲输出流 
     * @throws IOException 
     */  
    public static void codeStatics(File inFile, BufferedWriter bw)  
            throws IOException {  
  
        for (File file : inFile.listFiles()) {  
            if (file.isFile() && file.getName().endsWith(".java")||file.getName().endsWith(".js")||file.getName().endsWith(".jsp")||file.getName().endsWith(".xml")||file.getName().endsWith(".css")) {//为java 文件时  
                int line = 0;  
  
                BufferedReader br = new BufferedReader(new InputStreamReader(  
                        new FileInputStream(file), "utf-8"));//以utf-8 格式读入，若文件编码为gkb 则改为gbk  
                String s = null;  
                while ((s = br.readLine()) != null) {  
                    s = s.replaceAll("\\s", "");// \\s表示 空格,回车,换行等空白符,  
                                                // 将空白符替换为空字符""  
                      
                    if ("".equals(s)  
                            || s.startsWith("//")  
                            || s.startsWith("/*")    
                            || s.startsWith("/**")   
                            || s.startsWith("*")) {//过滤掉注释  
                    } else {  
                        line++;  
                        System.out.println(line + "：" + s);  
                    }  
                }  
                br.close();//关闭读入流  
                System.out.println(file.getName() + "\t\t" + line);// \t制表符(TAB)  
  
                bw.newLine();// 写入换行符  
                bw.write(file.getName() + "\t\t" + line);// 写入类名称  
                bw.newLine();// 换行  
                bw.flush();// 把缓冲区的数据强行写出  
  
                sumFile++;  
                sumLine += line;  
                System.out.println("统计:" + sumFile + "个类\t" + sumLine + "行");  
            } else if (file.isDirectory()) {// 当file 为目录时，递归遍历  
  
                codeStatics(file, bw);  
  
            }  
  
        }  
  
    }  
  
    public static void main(String[] args) {  
        try {  
            File inFile = new File("E:\\workspaceforWL\\pccw_project");// 要统计的项目  
            FileOutputStream ps = new FileOutputStream("D:/result.txt");// 将统计结果输出到txt文件  
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(ps,"utf-8"));  
            bw.write("类名\t\t行数");  
  
            codeStatics(inFile, bw);// 递归入口  
  
            bw.newLine();  
            bw.write("一共：" + sumFile + "个类\t\t" + sumLine + "行代码！");  
  
            bw.flush();  
            bw.close();//关闭输出流  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  
  
}  