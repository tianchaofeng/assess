/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.entity;

import org.hibernate.validator.constraints.Length;

import com.starsoft.ezicloud.common.persistence.DataEntity;

/**
 * 教案Entity
 * @author tcf
 * @version 2017-12-22
 */
public class ReTeacherplan extends DataEntity<ReTeacherplan> {
	
	private static final long serialVersionUID = 1L;
	private String teacherId;		// 老师
	private String classCourseChildId;		// 课程
	private String fileUrl;		// 文件路径
	
	public ReTeacherplan() {
		super();
	}

	public ReTeacherplan(String id){
		super(id);
	}

	@Length(min=1, max=64, message="老师长度必须介于 1 和 64 之间")
	public String getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(String teacherId) {
		this.teacherId = teacherId;
	}
	
	@Length(min=1, max=64, message="课程长度必须介于 1 和 64 之间")
	public String getClassCourseChildId() {
		return classCourseChildId;
	}

	public void setClassCourseChildId(String classCourseChildId) {
		this.classCourseChildId = classCourseChildId;
	}
	
	@Length(min=0, max=255, message="文件路径长度必须介于 0 和 255 之间")
	public String getFileUrl() {
		return fileUrl;
	}

	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}
	
}