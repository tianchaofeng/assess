/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.entity;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;
import com.starsoft.ezicloud.common.persistence.DataEntity;
import com.starsoft.ezicloud.common.utils.StringUtils;
import com.starsoft.ezicloud.common.utils.excel.annotation.ExcelField;
import com.starsoft.ezicloud.common.utils.excel.fieldtype.RoleListType;
import com.starsoft.ezicloud.modules.sys.entity.Office;
import com.starsoft.ezicloud.modules.sys.entity.Role;
import com.starsoft.ezicloud.modules.sys.utils.UserUtils;

/**
 * 问卷调查Entity
 * @author tcf
 * @version 2017-11-08
 */
public class DbQuestionnaireSurvey extends DataEntity<DbQuestionnaireSurvey> {
	
	private static final long serialVersionUID = 1L;
	private String bookunit;		// 单元
	private String subject;		// 学科
	private Office school;		// 学校
	private String name;		// 姓名
	private String gender;		// 性别
	private String age;		// 年龄
	private String education;		// 最终学历
	private String years;		// 教学年限
	private String times;		// 准备时间
	private String reference;		// 参考资料
	private String processingMode;		// 教材内容处理方式
	private String readyOrder;		// 准备顺序
	private String solveOrdedr;		// 解决顺序
	private String questionsOrder;		// 提问顺序
	private String teamOrder;		// 合作顺序
	private String homeworkOrder;		// 作业顺序
	private String correcting;		// 批改方式
	private String def1;		// 自定义1
	private String def2;		// 自定义2
	private String def3;		// 自定义3
	private String def4;		// 自定义4
	private String def5;		// 自定义5
	
	
	private List<String> referenceList = Lists.newArrayList(); // 参考资料
	private List<String> processingModeList = Lists.newArrayList(); // 教材内容处理方式
	private List<String> correctingList = Lists.newArrayList(); // 批改方式

	public List<String> getReferenceList() {
		if(StringUtils.isNoneEmpty(reference)){
			
			String[] strings = getReference().split(",");
			List<String> list = new ArrayList<String>();
			for (String string : strings) {
				list.add(string);
			}
			referenceList = list;
		}
		return referenceList;
	}

	public void setReferenceList(List<String> referenceList) {
		 StringBuffer str = new StringBuffer();
		for (String string : referenceList) {
			str.append(string).append(",");
		}
		reference = str.toString().substring(0, str.length()-1);
		setReference(reference);
		this.referenceList = referenceList;
	}


	public List<String> getProcessingModeList() {
		if(StringUtils.isNotBlank(processingMode)){
			String[] strings = getProcessingMode().split(",");
			List<String> list = new ArrayList<String>();
			for (String string : strings) {
				list.add(string);
			}
			processingModeList=list;
		}
		return processingModeList;
	}

	public void setProcessingModeList(List<String> processingModeList) {
		 StringBuffer str = new StringBuffer();
		for (String string : processingModeList) {
			str.append(string).append(",");
		}
		processingMode = str.toString().substring(0, str.length()-1);
		setReference(processingMode);
		this.processingModeList = processingModeList;
	}
	

	public List<String> getCorrectingList() {
		
		if(StringUtils.isNotBlank(correcting)){
			
			String[] strings = getCorrecting().split(",");
			List<String> list = new ArrayList<String>();
			for (String string : strings) {
				list.add(string);
			}
			correctingList = list;
		}
		return correctingList;
	}

	public void setCorrectingList(List<String> correctingList) {
		 StringBuffer str = new StringBuffer();
		for (String string : correctingList) {
			str.append(string).append(",");
		}
		correcting= str.toString().substring(0, str.length()-1);
		setCorrecting(correcting);
		this.correctingList = correctingList;
	}
	
	public DbQuestionnaireSurvey() {
		super();
	}

	public DbQuestionnaireSurvey(String id){
		super(id);
	}

	
	
	public String getBookunit() {
		return bookunit;
	}

	public void setBookunit(String bookunit) {
		this.bookunit = bookunit;
	}

	@Length(min=0, max=64, message="学科长度必须介于 0 和 64 之间")
	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	
	public Office getSchool() {
		return school;
	}

	public void setSchool(Office school) {
		this.school = school;
	}
	
	@Length(min=0, max=64, message="姓名长度必须介于 0 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=1, message="性别长度必须介于 0 和 1 之间")
	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}
	
	@Length(min=0, max=3, message="年龄长度必须介于 0 和 3 之间")
	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}
	
	@Length(min=0, max=64, message="最终学历长度必须介于 0 和 64 之间")
	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}
	
	@Length(min=0, max=5, message="教学年限长度必须介于 0 和 5 之间")
	public String getYears() {
		return years;
	}

	public void setYears(String years) {
		this.years = years;
	}
	
	@Length(min=0, max=5, message="准备时间长度必须介于 0 和 5 之间")
	public String getTimes() {
		return times;
	}

	public void setTimes(String times) {
		this.times = times;
	}
	
	@Length(min=0, max=255, message="参考资料长度必须介于 0 和 255 之间")
	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}
	
	@Length(min=0, max=64, message="教材内容处理方式长度必须介于 0 和 64 之间")
	public String getProcessingMode() {
		return processingMode;
	}

	public void setProcessingMode(String processingMode) {
		this.processingMode = processingMode;
	}
	
	@Length(min=0, max=64, message="准备顺序长度必须介于 0 和 64 之间")
	public String getReadyOrder() {
		return readyOrder;
	}

	public void setReadyOrder(String readyOrder) {
		this.readyOrder = readyOrder;
	}
	
	@Length(min=0, max=64, message="解决顺序长度必须介于 0 和 64 之间")
	public String getSolveOrdedr() {
		return solveOrdedr;
	}

	public void setSolveOrdedr(String solveOrdedr) {
		this.solveOrdedr = solveOrdedr;
	}
	
	@Length(min=0, max=64, message="提问顺序长度必须介于 0 和 64 之间")
	public String getQuestionsOrder() {
		return questionsOrder;
	}

	public void setQuestionsOrder(String questionsOrder) {
		this.questionsOrder = questionsOrder;
	}
	
	@Length(min=0, max=64, message="合作顺序长度必须介于 0 和 64 之间")
	public String getTeamOrder() {
		return teamOrder;
	}

	public void setTeamOrder(String teamOrder) {
		this.teamOrder = teamOrder;
	}
	
	@Length(min=0, max=64, message="作业顺序长度必须介于 0 和 64 之间")
	public String getHomeworkOrder() {
		return homeworkOrder;
	}

	public void setHomeworkOrder(String homeworkOrder) {
		this.homeworkOrder = homeworkOrder;
	}
	
	@Length(min=0, max=64, message="批改方式长度必须介于 0 和 64 之间")
	public String getCorrecting() {
		return correcting;
	}

	public void setCorrecting(String correcting) {
		this.correcting = correcting;
	}
	
	@Length(min=0, max=64, message="自定义1长度必须介于 0 和 64 之间")
	public String getDef1() {
		return def1;
	}

	public void setDef1(String def1) {
		this.def1 = def1;
	}
	
	@Length(min=0, max=64, message="自定义2长度必须介于 0 和 64 之间")
	public String getDef2() {
		return def2;
	}

	public void setDef2(String def2) {
		this.def2 = def2;
	}
	
	@Length(min=0, max=64, message="自定义3长度必须介于 0 和 64 之间")
	public String getDef3() {
		return def3;
	}

	public void setDef3(String def3) {
		this.def3 = def3;
	}
	
	@Length(min=0, max=64, message="自定义4长度必须介于 0 和 64 之间")
	public String getDef4() {
		return def4;
	}

	public void setDef4(String def4) {
		this.def4 = def4;
	}
	
	@Length(min=0, max=64, message="自定义5长度必须介于 0 和 64 之间")
	public String getDef5() {
		return def5;
	}

	public void setDef5(String def5) {
		this.def5 = def5;
	}
	
}