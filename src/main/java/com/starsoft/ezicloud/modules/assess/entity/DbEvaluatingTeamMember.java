/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.entity;

import org.hibernate.validator.constraints.Length;

import com.starsoft.ezicloud.common.persistence.DataEntity;
import com.starsoft.ezicloud.modules.sys.entity.User;

/**
 * 评价小组Entity
 * @author suxl
 * @version 2017-09-19
 */
public class DbEvaluatingTeamMember extends DataEntity<DbEvaluatingTeamMember> {
	
	private static final long serialVersionUID = 1L;
	private DbEvaluatingTeam teamId;		// 所属小组
	private User memberId;		// 组员
	private String def1;		// 自定义1
	private String def2;		// 自定义2
	private String def3;		// 自定义3
	private String def4;		// 自定义4
	private String def5;		// 自定义5
	
	public DbEvaluatingTeamMember(DbEvaluatingTeam teamId) {
		this.teamId=teamId;
	}
	
	public DbEvaluatingTeamMember() {
		super();
	}

	public DbEvaluatingTeamMember(String id){
		super(id);
	}

	@Length(min=1, max=64, message="所属小组长度必须介于 1 和 64 之间")
	public DbEvaluatingTeam getTeamId() {
		return teamId;
	}

	public void setTeamId(DbEvaluatingTeam teamId) {
		this.teamId = teamId;
	}
	
	@Length(min=1, max=64, message="组员长度必须介于 1 和 64 之间")
	public User getMemberId() {
		return memberId;
	}

	public void setMemberId(User memberId) {
		this.memberId = memberId;
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