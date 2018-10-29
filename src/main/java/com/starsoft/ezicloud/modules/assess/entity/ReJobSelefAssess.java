/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.entity;

import org.hibernate.validator.constraints.Length;

import com.starsoft.ezicloud.common.persistence.DataEntity;

/**
 * 个人任务与考核指标Entity
 * @author tcf
 * @version 2017-09-19
 */
public class ReJobSelefAssess extends DataEntity<ReJobSelefAssess> {
	
	private static final long serialVersionUID = 1L;
	private DbJobSelf jobSelfId;		// 个人任务id
	private DbAssessIndex assessId;		// 指标id
	private float proportion;		// 比重
	private double score;		// 得分
	private String def1;		// 自定义1
	private String def2;		// 自定义2
	private String def3;		// 自定义3
	private String def4;		// 自定义4
	private String def5;		// 自定义5
	
	public ReJobSelefAssess() {
		super();
	}

	public ReJobSelefAssess(String id){
		super(id);
	}

	@Length(min=0, max=64, message="个人任务id长度必须介于 0 和 64 之间")
	public DbJobSelf getJobSelfId() {
		return jobSelfId;
	}

	public void setJobSelfId(DbJobSelf jobSelfId) {
		this.jobSelfId = jobSelfId;
	}
	
	@Length(min=1, max=64, message="指标id长度必须介于 1 和 64 之间")
	public DbAssessIndex getAssessId() {
		return assessId;
	}

	public void setAssessId(DbAssessIndex assessId) {
		this.assessId = assessId;
	}
	
	public float getProportion() {
		return proportion;
	}

	public void setProportion(float proportion) {
		this.proportion = proportion;
	}
	
	@Length(min=0, max=3, message="得分长度必须介于 0 和 3 之间")
	public double getScore() {
		return score;
	}

	public void setScore(double score) {
		this.score = score;
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