/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.entity;

import org.hibernate.validator.constraints.Length;

import com.starsoft.ezicloud.common.persistence.DataEntity;

/**
 * 班级课程信息Entity
 * @author suxl
 * @version 2017-10-10
 */
public class DbClassCourseChild extends DataEntity<DbClassCourseChild> {
	
	private static final long serialVersionUID = 1L;
	private DbClassCourse pid;		// 主表id
	private String chapter;		// 章节
	private String def1;		// url
	private String def2;		// 自定义2
	private String def3;		// 自定义3
	private String def4;		// 自定义4
	private String def5;		// 自定义5
	
	public DbClassCourseChild() {
		super();
	}

	
	public DbClassCourseChild(DbClassCourse pid) {
//		super();
		this.pid = pid;
	}



	public DbClassCourseChild(String id){
		super(id);
	}

	public DbClassCourse getPid() {
		return pid;
	}

	public void setPid(DbClassCourse pid) {
		this.pid = pid;
	}
	
	@Length(min=0, max=64, message="章节长度必须介于 0 和 64 之间")
	public String getChapter() {
		return chapter;
	}

	public void setChapter(String chapter) {
		this.chapter = chapter;
	}
	
	@Length(min=0, max=255, message="自定义1长度必须介于 0 和 255 之间")
	public String getDef1() {
		return def1;
	}

	public void setDef1(String def1) {
		this.def1 = def1;
	}
	
	@Length(min=0, max=255, message="自定义2长度必须介于 0 和 255 之间")
	public String getDef2() {
		return def2;
	}

	public void setDef2(String def2) {
		this.def2 = def2;
	}
	
	@Length(min=0, max=255, message="自定义3长度必须介于 0 和 255 之间")
	public String getDef3() {
		return def3;
	}

	public void setDef3(String def3) {
		this.def3 = def3;
	}
	
	@Length(min=0, max=255, message="自定义4长度必须介于 0 和 255 之间")
	public String getDef4() {
		return def4;
	}

	public void setDef4(String def4) {
		this.def4 = def4;
	}
	
	@Length(min=0, max=255, message="自定义5长度必须介于 0 和 255 之间")
	public String getDef5() {
		return def5;
	}

	public void setDef5(String def5) {
		this.def5 = def5;
	}
	
}