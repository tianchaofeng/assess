package com.starsoft.ezicloud.modules.assess.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.starsoft.ezicloud.common.service.CrudService;
import com.starsoft.ezicloud.modules.assess.dao.DbClassCourseChildDao;
import com.starsoft.ezicloud.modules.assess.entity.DbClassCourseChild;
import com.starsoft.ezicloud.modules.assess.entity.ReTeacherplan;
@Service
@Transactional(readOnly = true)
public class DbClassCourseChildService extends CrudService<DbClassCourseChildDao, DbClassCourseChild> {
	@Autowired
	private DbClassCourseChildDao dbClassCourseChildDao;
	@Autowired
	private ReTeacherplanService reTeacherplanService;
	
	public List<DbClassCourseChild> findList(DbClassCourseChild dbClassCourseChild,String teacherid) {
		List<DbClassCourseChild> entitylist = new ArrayList<DbClassCourseChild>();
		List<DbClassCourseChild> list = dbClassCourseChildDao.findAllList(dbClassCourseChild);
		for (DbClassCourseChild dbClassCourseChild2 : list) {
			ReTeacherplan plan = new ReTeacherplan();
			plan.setTeacherId(teacherid);
			plan.setClassCourseChildId(dbClassCourseChild2.getId());
			List<ReTeacherplan> list2 = reTeacherplanService.findList(plan);
			if (list2 != null && list.size() >0) {
				dbClassCourseChild2.setDef1(list2.get(0).getFileUrl());
				entitylist.add(dbClassCourseChild2);
			}else {
				entitylist.add(dbClassCourseChild2);
			}
		}
		
		return entitylist;
	}
}
