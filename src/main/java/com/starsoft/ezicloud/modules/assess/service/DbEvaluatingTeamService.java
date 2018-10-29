/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.starsoft.ezicloud.common.persistence.Page;
import com.starsoft.ezicloud.common.service.CrudService;
import com.starsoft.ezicloud.common.utils.StringUtils;
import com.starsoft.ezicloud.modules.assess.dao.DbEvaluatingTeamDao;
import com.starsoft.ezicloud.modules.assess.dao.DbEvaluatingTeamMemberDao;
import com.starsoft.ezicloud.modules.assess.entity.DbEvaluatingTeam;
import com.starsoft.ezicloud.modules.assess.entity.DbEvaluatingTeamMember;
import com.starsoft.ezicloud.modules.sys.dao.UserDao;
import com.starsoft.ezicloud.modules.sys.utils.UserUtils;

/**
 * 评价小组Service
 * @author suxl
 * @version 2017-09-19
 */
@Service
@Transactional(readOnly = true)
public class DbEvaluatingTeamService extends CrudService<DbEvaluatingTeamDao, DbEvaluatingTeam> {

	@Autowired
	private DbEvaluatingTeamMemberDao dbEvaluatingTeamMemberDao;
	
	@Autowired
	private UserDao userDao;
	
	public DbEvaluatingTeam get(String id) {
		DbEvaluatingTeam dbEvaluatingTeam = super.get(id);
		dbEvaluatingTeam.setDbEvaluatingTeamMemberList(dbEvaluatingTeamMemberDao.findList(new DbEvaluatingTeamMember(dbEvaluatingTeam)));
		return dbEvaluatingTeam;
	}
	
	public List<DbEvaluatingTeam> findList(DbEvaluatingTeam dbEvaluatingTeam) {
		return super.findList(dbEvaluatingTeam);
	}
	
	public Page<DbEvaluatingTeam> findPage(Page<DbEvaluatingTeam> page, DbEvaluatingTeam dbEvaluatingTeam) {
		if(dbEvaluatingTeam.getTemaHeader() == null && !UserUtils.getUser().isAdmin() ){
			dbEvaluatingTeam.setTemaHeader(UserUtils.getUser());
		}
		
		return super.findPage(page, dbEvaluatingTeam);
	}
	
	@Transactional(readOnly = false)
	public void save(DbEvaluatingTeam dbEvaluatingTeam) {
		super.save(dbEvaluatingTeam);
		for (DbEvaluatingTeamMember dbEvaluatingTeamMember : dbEvaluatingTeam.getDbEvaluatingTeamMemberList()){
			if (dbEvaluatingTeamMember.getId() == null){
				continue;
			}
			if (DbEvaluatingTeamMember.DEL_FLAG_NORMAL.equals(dbEvaluatingTeamMember.getDelFlag())){
				if (StringUtils.isBlank(dbEvaluatingTeamMember.getId())){
					dbEvaluatingTeamMember.setTeamId(dbEvaluatingTeam);
					dbEvaluatingTeamMember.preInsert();
					dbEvaluatingTeamMemberDao.insert(dbEvaluatingTeamMember);
				}else{
					dbEvaluatingTeamMember.preUpdate();
					dbEvaluatingTeamMemberDao.update(dbEvaluatingTeamMember);
				}
			}else{
				dbEvaluatingTeamMemberDao.delete(dbEvaluatingTeamMember);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(DbEvaluatingTeam dbEvaluatingTeam) {
		super.delete(dbEvaluatingTeam);
		dbEvaluatingTeamMemberDao.delete(new DbEvaluatingTeamMember(dbEvaluatingTeam));
	}
	
}