package assess;

import java.util.ArrayList;
import java.util.List;

import com.starsoft.ezicloud.common.utils.Collections3;
import com.starsoft.ezicloud.common.utils.StringUtils;

public class clauseNumTest {

	/**
	 * 数字变更
	 * 1 -> 2
	 * 1.1 -> 1.2
	 * 1.1.1 -> 1.1.2
	 * @author tcf
	 * */
	private static String updateStr(String str){
		String[] strings = str.split("\\.");
		String ss = strings[strings.length-1];
		ss = String.valueOf(Integer.valueOf(ss)+1);
		strings[strings.length-1] = ss;
		StringBuffer s = new StringBuffer();
		for(int i=0;i<strings.length;i++){
			s.append(strings[i]).append(".");
		}
		
		return s.toString().substring(0, s.length()-1);
	}
	
	/**
	 * 递归更新条款集合
	 * @param str 需要变更条款号
	 * @param list 需要变更的集合
	 * */
	public static List<String> updateclause(String str,List<String> list){
		List<String> lst = new ArrayList<String>();
		List<String> list1 = new ArrayList<String>();
		List<String> list2 = new ArrayList<String>();
		 String   str1 = updateStr(str);
		 
		 
		 System.out.println("初始值:"+str);
		 System.out.println("变更值:"+str1);
		for (String string : list) {
			if(string.equals(str) || string.startsWith(str+".") ){
				list1.add(string);
				list2.add(string.replaceFirst(str, str1));
			}
		}
 
		System.out.println("初始list:"+list);
		list.removeAll(list1);
		System.out.println("无疑义list:"+list);
		System.out.println("有疑义list:"+list1);
		System.out.println("变更list:"+list2);
		
		List<String> list3 = Collections3.intersection(list, list2);
//		lst.addAll(list);
		lst.addAll(list2);
		if(list3.size()==0){
			lst.addAll(list);
		}else{
			for (String string : list3) {
				lst.addAll(updateclause(string, list));
			}
		}
		
		System.err.println("最终list:"+lst);
		
		return lst;
	}
	
	/**
	 * @param str 待修改数值,为空时为新增
	 * @param str1   修改后的值或要新增的值
	 * */
	public static List<String> updateclause(String str,String str1,List<String> list){
		List<String> lst = new ArrayList<String>();
		List<String> list1 = new ArrayList<String>();
		List<String> list2 = new ArrayList<String>();
		
		if(StringUtils.isBlank(str)){
			/*list.add(str1);
			return list;*/
			if(!list.contains(str1)){
				list.add(str1);
				return list;
			}else{
				lst = updateclause(str1,list);
				System.out.println(lst);
				lst.add(str1);
				System.out.println(lst);
				return lst;
			}
		}
		
		
		System.out.println("初始值:"+str);
		System.out.println("变更值:"+str1);
		for (String string : list) {
			if(string.equals(str) || string.startsWith(str+".") ){
				list1.add(string);
				list2.add(string.replaceFirst(str, str1));
			}
		}
		
		System.out.println("初始list:"+list);
		list.removeAll(list1);
		System.out.println("无疑义list:"+list);
		System.out.println("有疑义list:"+list1);
		System.out.println("变更list:"+list2);
		
		List<String> list3 = Collections3.intersection(list, list2);
//		lst.addAll(list);
		lst.addAll(list2);
		if(list3.size()==0){
			lst.addAll(list);
		}else{
			for (String string : list3) {
				lst.addAll(updateclause(string, list));
			}
		}
		
		System.err.println("最终list:"+lst);
		
		return lst;
	}
	
	
	
	public static void main(String[] args) {
		List<String> list = new ArrayList<String>();
		list.add("1");
		list.add("1.1");
		list.add("1.2");
		list.add("1.2.1");
		/*list.add("1.3");
		list.add("2");
		list.add("2.1");
		list.add("2.1.1");
		list.add("2.1.1.1");
		list.add("2.1.1.2");
		list.add("2.1.2");
		list.add("2.11.1");
		list.add("2.12.1");
		list.add("3");*/

		
		//List<String> list2 = clauseNumTest.updateclause("","1.1", list);
	//	System.out.println("==================="+list2);
		

		String s ="1";
		s=s.replaceFirst("1", "2");
		System.out.println(s);
	}

}
