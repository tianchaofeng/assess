/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.starsoft.ezicloud.common.persistence.Page;
import com.starsoft.ezicloud.common.service.CrudService;
import com.starsoft.ezicloud.common.utils.Collections3;
import com.starsoft.ezicloud.common.utils.StringUtils;
import com.starsoft.ezicloud.modules.assess.dao.DbClassCourseChildDao;
import com.starsoft.ezicloud.modules.assess.dao.DbClassCourseDao;
import com.starsoft.ezicloud.modules.assess.entity.DbClassCourse;
import com.starsoft.ezicloud.modules.assess.entity.DbClassCourseChild;
import com.starsoft.ezicloud.modules.assess.entity.ReTeacherplan;
import com.starsoft.ezicloud.modules.sys.entity.User;
import com.starsoft.ezicloud.modules.sys.utils.DictUtils;

/**
 * 班级课程信息Service
 * @author suxl
 * @version 2017-10-10
 */
@Service
@Transactional(readOnly = true)
public class DbClassCourseService extends CrudService<DbClassCourseDao, DbClassCourse> {

	@Autowired
	private DbClassCourseChildDao dbClassCourseChildDao;
	@Autowired
	private ReTeacherplanService reTeacherplanService;
	
	public DbClassCourse get(String id) {
		DbClassCourse dbClassCourse = super.get(id);
		dbClassCourse.setDbClassCourseChildList(dbClassCourseChildDao.findList(new DbClassCourseChild(dbClassCourse)));
		return dbClassCourse;
	}
	
	public List<DbClassCourse> findList(DbClassCourse dbClassCourse) {
		return super.findList(dbClassCourse);
	}
	
	public Page<DbClassCourse> findPage(Page<DbClassCourse> page, DbClassCourse dbClassCourse) {
		return super.findPage(page, dbClassCourse);
	}
	
	@Transactional(readOnly = false)
	public void save(DbClassCourse dbClassCourse) {
		super.save(dbClassCourse);
		for (DbClassCourseChild dbClassCourseChild : dbClassCourse.getDbClassCourseChildList()){
			if (dbClassCourseChild.getId() == null){
				continue;
			}
			if (DbClassCourseChild.DEL_FLAG_NORMAL.equals(dbClassCourseChild.getDelFlag())){
				if (StringUtils.isBlank(dbClassCourseChild.getId())){
					dbClassCourseChild.preInsert();
					dbClassCourseChild.setPid(dbClassCourse);
					dbClassCourseChildDao.insert(dbClassCourseChild);
					if (StringUtils.isNotBlank(dbClassCourseChild.getDef1())) {
					String url = dbClassCourseChild.getDef1();
					User teacher = dbClassCourseChild.getUpdateBy();
					String course_child_id = dbClassCourseChild.getId();
					ReTeacherplan	reTeacherplan   = new ReTeacherplan() ;
					reTeacherplan.setTeacherId(teacher.getId());
					reTeacherplan.setClassCourseChildId(course_child_id);
					reTeacherplan.setFileUrl(url);
					reTeacherplan.setUpdateDate(new Date());
					reTeacherplanService.save(reTeacherplan);
					}
				}else{
					dbClassCourseChild.preUpdate();
					dbClassCourseChildDao.update(dbClassCourseChild);
					if (StringUtils.isNotBlank(dbClassCourseChild.getDef1())) {
					String url = dbClassCourseChild.getDef1();
					User teacher = dbClassCourseChild.getUpdateBy();
					String course_child_id = dbClassCourseChild.getId();
					ReTeacherplan	reTeacherplan   = new ReTeacherplan() ;
					reTeacherplan.setTeacherId(teacher.getId());
					reTeacherplan.setClassCourseChildId(course_child_id);
					reTeacherplan.setFileUrl(url);
					reTeacherplan.setUpdateDate(new Date());
					reTeacherplanService.save(reTeacherplan);
					}
				}
			}else{
				dbClassCourseChildDao.delete(dbClassCourseChild);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(DbClassCourse dbClassCourse) {
		super.delete(dbClassCourse);
		dbClassCourseChildDao.delete(new DbClassCourseChild(dbClassCourse));
	}

	@SuppressWarnings("unchecked")
	public DbClassCourse getById(String ids) {
		DbClassCourse dbClassCourse = get(ids);
		dbClassCourse.setVersion(DictUtils.getDictLabel(dbClassCourse.getVersion(), "book_version", ""));
		dbClassCourse.setGrade(DictUtils.getDictLabel(dbClassCourse.getGrade(), "student_grade", ""));
		dbClassCourse.setCe(DictUtils.getDictLabel(dbClassCourse.getCe(), "up_down", ""));
		@SuppressWarnings("rawtypes")
		List list = Collections3.extractToList(dbClassCourse.getDbClassCourseChildList(), "chapter");
		dbClassCourse.setDbList(list);
		return dbClassCourse;
	}
	
}