/**
 * Copyright &copy; 2012-2016 <a href="http://www.stars-soft.com/">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.sys.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.starsoft.ezicloud.common.service.TreeService;
import com.starsoft.ezicloud.modules.sys.dao.OfficeDao;
import com.starsoft.ezicloud.modules.sys.entity.Office;
import com.starsoft.ezicloud.modules.sys.utils.UserUtils;

/**
 * 机构Service
 * @author EziCloud
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class OfficeService extends TreeService<OfficeDao, Office> {

	public List<Office> findAll(){
		return UserUtils.getOfficeList();
	}

	public List<Office> findList(Boolean isAll){
		if (isAll != null && isAll){
			return UserUtils.getOfficeAllList();
		}else{
			return UserUtils.getOfficeList();
		}
	}
	
	@Transactional(readOnly = true)
	public List<Office> findList(Office office){
		if(office != null){
			office.setParentIds(office.getParentIds()+"%");
			return dao.findByParentIdsLike(office);
		}
		return  new ArrayList<Office>();
	}
	
	@Transactional(readOnly = false)
	public void save(Office office) {
		super.save(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}
	
	@Transactional(readOnly = false)
	public void delete(Office office) {
		super.delete(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}

	public List<Office> getByType(Office office) {
		// TODO Auto-generated method stub
		return dao.getByType(office);
	}
	
}
