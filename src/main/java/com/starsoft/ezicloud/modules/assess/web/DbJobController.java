/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.web;

import com.beust.jcommander.internal.Lists;
import com.starsoft.ezicloud.common.config.Global;
import com.starsoft.ezicloud.common.persistence.Page;
import com.starsoft.ezicloud.common.utils.DateUtils;
import com.starsoft.ezicloud.common.utils.IdGen;
import com.starsoft.ezicloud.common.utils.StringUtils;
import com.starsoft.ezicloud.common.utils.excel.ExportExcel;
import com.starsoft.ezicloud.common.web.BaseController;
import com.starsoft.ezicloud.modules.assess.dao.*;
import com.starsoft.ezicloud.modules.assess.entity.*;
import com.starsoft.ezicloud.modules.assess.service.DbClassCourseService;
import com.starsoft.ezicloud.modules.assess.service.DbEvaluatingTeamService;
import com.starsoft.ezicloud.modules.assess.service.DbJobService;
import com.starsoft.ezicloud.modules.assess.service.ReTeacherplanService;
import com.starsoft.ezicloud.modules.sys.entity.User;
import com.starsoft.ezicloud.modules.sys.utils.DictUtils;
import com.starsoft.ezicloud.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.DecimalFormat;
import java.util.*;

/**
 * 任务创建Controller
 * @author suxl
 * @version 2017-09-19
 */
@Controller
@RequestMapping(value = "${adminPath}/assess/dbJob")
public class DbJobController extends BaseController {

	@Autowired
	private DbJobService dbJobService;
	
	@Autowired
	private DbEvaluatingTeamService dbEvaluatingTeamService;
	@Autowired
	private DbJobSelfDao dbJobSelfDao;
	@Autowired
	private ReQuestionnaireAssessDao reQuestionnaireAssessDao;
	@Autowired
	private DbAssessIndexDao dbAssessIndexDao;
	@Autowired
	private DbLevelDao dbLevelDao;
	@Autowired
	private ReJobSelefAssessDao reJobSelefAssessDao;
	@Autowired
	private DbClassCourseService dbClassCourseService;
	@Autowired
	private ReTeacherplanService reTeacherplanService;
	
	@ModelAttribute
	public DbJob get(@RequestParam(required=false) String id) {
		DbJob entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dbJobService.get(id);
		}
		if (entity == null){
			entity = new DbJob();
		}
		return entity;
	}
	
	@RequiresPermissions("assess:dbJob:view")
	@RequestMapping(value = {"list", ""})
	public String list(DbJob dbJob, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DbJob> page = dbJobService.findPage(new Page<DbJob>(request, response), dbJob);
		for(DbJob job : page.getList()){
			DbJobSelf dbJobSelf = new DbJobSelf();
			dbJobSelf.setJobId(job);
			dbJobSelf.setDef2("2");  //个人任务状态为提交的
			List<DbJobSelf> dbJobSelfList = dbJobSelfDao.findList(dbJobSelf);    //个人任务
			if(dbJobSelfList.size() == 0){
				job.setDef1("0");
			}
			
			double total = 0;
			for(DbJobSelf jobSelf : dbJobSelfList){
				ReJobSelefAssess reJobSelefAssess = new ReJobSelefAssess();
				reJobSelefAssess.setJobSelfId(jobSelf);
				jobSelf.setReJobSelefAssessList(reJobSelefAssessDao.findList(reJobSelefAssess));
				String sum = reJobSelefAssessDao.sum(jobSelf.getId());
				if(StringUtils.isNotBlank(sum)){
					jobSelf.setDef1(sum);
					double valueOf = Double.valueOf(sum);
					total+=valueOf;
				}
			}
			DecimalFormat df = new DecimalFormat("0.00");//格式化小数  
			if(total ==0 || dbJobSelfList.size() == 0){
				job.setDef2("0");
			}else{
		        String average = df.format((float)total/dbJobSelfList.size());//返回的是String类型
		        job.setDef2(average);
			}
		}
		model.addAttribute("page", page);
		return "modules/assess/dbJobList";
	}

	@RequiresPermissions("assess:dbJob:view")
	@RequestMapping(value = "form")
	public String form(DbJob dbJob, Model model) {
		if (StringUtils.isNotBlank(dbJob.getId())) {
			if (dbJob.getDiscipline()!=null) {
				DbClassCourse dbClassCourse = dbClassCourseService.getById(dbJob.getDiscipline().getId());
				model.addAttribute("dbClassCourse", dbClassCourse);
			}
			
			dbJob.setVersion(DictUtils.getDictLabel(dbJob.getVersion(), "book_version", ""));
			dbJob.setGrade(DictUtils.getDictLabel(dbJob.getGrade(), "student_grade", ""));
			dbJob.setCe(DictUtils.getDictLabel(dbJob.getCe(), "up_down", ""));
		}
		
		model.addAttribute("dbJob", dbJob);
		return "modules/assess/dbJobForm";
	}

	@RequiresPermissions("assess:dbJob:view")
	@RequestMapping(value = "detail")
	public String detail(DbJob dbJob, Model model) {
		model.addAttribute("dbJob", dbJob);
		return "modules/assess/dbJobDetail";
	}

	@RequiresPermissions("assess:dbJob:tp")
	@RequestMapping(value = "teacheingPlan")
	public String saveteacheingPlan(DbJob dbJob, Model model, RedirectAttributes redirectAttributes) {
		saveentiy(dbJob);
		String url  = dbJob.getDef5();
		String teacherid = dbJob.getEvaluationTarget().getId();
		String coursechuildid = dbJob.getDef3();
		
		if(StringUtils.isNotBlank(url)&&StringUtils.isNotBlank(coursechuildid)){
			ReTeacherplan	reTeacherplan   = new ReTeacherplan() ;
			reTeacherplan.setTeacherId(teacherid);
			reTeacherplan.setClassCourseChildId(coursechuildid);
			
			List<ReTeacherplan> list = reTeacherplanService.findList(reTeacherplan);
			if(list != null && list.size() > 0){
				ReTeacherplan reTeacherplan2 = list.get(0);
				reTeacherplan2.setFileUrl(url);
				reTeacherplanService.save(reTeacherplan2);
			}else{
				reTeacherplan.setUpdateDate(new Date());
				reTeacherplan.setFileUrl(url);
				reTeacherplanService.save(reTeacherplan);
			}
		}
		
		
		addMessage(redirectAttributes, "提交教案成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbJob/?repage";
	}
	@RequiresPermissions("assess:dbJob:edit")
	@RequestMapping(value = "save")
	public String save(DbJob dbJob, Model model, RedirectAttributes redirectAttributes) {
		saveentiy(dbJob);
		
		addMessage(redirectAttributes, "保存任务创建成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbJob/?repage";
	}

	private void saveentiy(DbJob dbJob) {
		String id = dbJob.getId();
		String type = StringUtils.isBlank(dbJob.getType())?"0":dbJob.getType();
		dbJob.setType(type);
		
		if (!"0".equals(type)) {//不是评分者评价教师
			dbJob.setGrade("");
			dbJob.setCe("");
			dbJob.setChapter("");
			dbJob.setBookunit("");
			dbJob.setDiscipline(null);
			dbJob.setChapter("");
			dbJob.setVersion("");
		}else {
			dbJob.setVersion(DictUtils.getDictValue(dbJob.getVersion(), "book_version", ""));
			dbJob.setGrade(DictUtils.getDictValue(dbJob.getGrade(), "student_grade", ""));
			dbJob.setCe(DictUtils.getDictValue(dbJob.getCe(), "up_down", ""));
//			dbJob.setDiscipline(DictUtils.getDictValue(dbJob.getDiscipline(), "subject", ""));
		}
//		if (StringUtils.isBlank(dbJob.getId())) {
//			dbJob.setVersion(DictUtils.getDictValue(dbJob.getVersion(), "book_version", ""));
//			dbJob.setGrade(DictUtils.getDictValue(dbJob.getGrade(), "student_grade", ""));
//			dbJob.setCe(DictUtils.getDictValue(dbJob.getCe(), "up_down", ""));
//		}
		
		dbJobService.save(dbJob);
		if ("0".equals(type)) {//评分者评价教师
			if (StringUtils.isBlank(id)) {
				DbEvaluatingTeam dbEvaluatingTeam = dbJob.getTeamId();//参评小组
				if (dbEvaluatingTeam!=null) {
					String id1 = dbEvaluatingTeam.getId();//参评小组id
					DbEvaluatingTeam dbEvaluatingTeam2 = dbEvaluatingTeamService.get(id1);
					List<DbEvaluatingTeamMember> dbEvaluatingTeamMemberList = dbEvaluatingTeam2.getDbEvaluatingTeamMemberList();
					for (DbEvaluatingTeamMember dbEvaluatingTeamMember : dbEvaluatingTeamMemberList) {//参评小组中的参评人
						String id2 = dbEvaluatingTeamMember.getMemberId().getId();//参评人id
						DbJobSelf dbJobSelf = new DbJobSelf();
						dbJobSelf.setId(IdGen.uuid());
						dbJobSelf.setJobId(dbJob);//任务id
						dbJobSelf.setVersion(dbJob.getVersion());
						dbJobSelf.setGrade(dbJob.getGrade());
						dbJobSelf.setDiscipline(dbJob.getDiscipline());
						dbJobSelf.setCe(dbJob.getCe());
						dbJobSelf.setChapter(dbJob.getChapter());
						dbJobSelf.setBookunit(dbJob.getBookunit());
						dbJobSelf.setTarget(dbJob.getEvaluationTarget());//考评目标
						dbJobSelf.setParticipant(new User(id2));//参评人
						dbJobSelf.setCreateBy(UserUtils.getUser());
						dbJobSelf.setCreateDate(new Date());
						dbJobSelf.setUpdateBy(UserUtils.getUser());
						dbJobSelf.setUpdateDate(new Date());
						dbJobSelf.setDef1("0");
						dbJobSelfDao.insert(dbJobSelf);
					}
					DbJobSelf dbJobSelf = new DbJobSelf();
					dbJobSelf.setId(IdGen.uuid());
					dbJobSelf.setJobId(dbJob);//任务id
					dbJobSelf.setVersion(dbJob.getVersion());
					dbJobSelf.setGrade(dbJob.getGrade());
					dbJobSelf.setDiscipline(dbJob.getDiscipline());
					dbJobSelf.setCe(dbJob.getCe());
					dbJobSelf.setChapter(dbJob.getChapter());
					dbJobSelf.setBookunit(dbJob.getBookunit());
					dbJobSelf.setTarget(dbJob.getEvaluationTarget());//考评目标
					dbJobSelf.setParticipant(dbJob.getEvaluationTarget());//参评人
					dbJobSelf.setCreateBy(UserUtils.getUser());
					dbJobSelf.setCreateDate(new Date());
					dbJobSelf.setUpdateBy(UserUtils.getUser());
					dbJobSelf.setUpdateDate(new Date());
					dbJobSelf.setDef1("0");
					dbJobSelfDao.insert(dbJobSelf);
					
				}
			}else {
				List<DbJobSelf> list=dbJobSelfDao.getByJobId(dbJob.getId());
				for (DbJobSelf dbJobSelf : list) {
					dbJobSelf.setTarget(dbJob.getEvaluationTarget());//考评目标
					dbJobSelf.setVersion(dbJob.getVersion());
					dbJobSelf.setGrade(dbJob.getGrade());
					dbJobSelf.setDiscipline(dbJob.getDiscipline());
					dbJobSelf.setCe(dbJob.getCe());
					dbJobSelf.setChapter(dbJob.getChapter());
					dbJobSelf.setBookunit(dbJob.getBookunit());
					dbJobSelf.setUpdateDate(new Date());
					dbJobSelf.setUpdateBy(UserUtils.getUser());
					dbJobSelfDao.update(dbJobSelf);
				}
			}
		}
	}
	
	@RequiresPermissions("assess:dbJob:edit")
	@RequestMapping(value = "delete")
	public String delete(DbJob dbJob, RedirectAttributes redirectAttributes) {
		dbJobService.delete(dbJob);
		addMessage(redirectAttributes, "删除任务创建成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbJob/?repage";
	}
	
	@RequiresPermissions("assess:dbJob:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(DbJob dbJob, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "任务创建" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<DbJob> page = dbJobService.findPage(new Page<DbJob>(request, response, -1), dbJob);
			// 解决firefox下载中文无法显示的问题
			String UserAgent = request.getHeader("USER-AGENT").toLowerCase();
			new ExportExcel("任务创建", DbJob.class).setDataList(page.getList()).write(response, fileName, !UserAgent.contains("firefox")).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出任务创建失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/assess/dbJob/list?repage";
	}
	
	@RequiresPermissions("assess:dbJob:view")
	@RequestMapping(value = "reference", method = RequestMethod.POST)
	public String selectList(DbJob dbJob, HttpServletRequest request, HttpServletResponse response, Model model) {
		list(dbJob, request, response, model);
		return "modules/assess/dbJobReferenceList";
	}
	/**
	 * 评分表格
	 * @param dbJobSelf
	 * @param model
	 * @return
	 *@author  zsd
	 *@date 2017年9月25日 下午5:31:09
	 */
	@RequiresPermissions("assess:dbJobSelf:view")
	@RequestMapping(value = "table")
	public String table(DbJob dbJob, Model model) {
		DbQuestionnaire questionnaireId = dbJob.getQuestionnaireId();   //问卷id
		ReQuestionnaireAssess questionnaireAssess = new ReQuestionnaireAssess();
		questionnaireAssess.setQuestionnaireId(questionnaireId);
		List<ReQuestionnaireAssess> reQAList = reQuestionnaireAssessDao.findList(questionnaireAssess);  //问卷子表  list
		DbJobSelf dbJobSelf = new DbJobSelf();
		dbJobSelf.setJobId(dbJob);
		dbJobSelf.setDef2("2");
		List<DbJobSelf> dbJobSelfList = dbJobSelfDao.findList(dbJobSelf);    //个人任务
		double total = 0;
		for(DbJobSelf jobSelf : dbJobSelfList){
			ReJobSelefAssess reJobSelefAssess = new ReJobSelefAssess();
			reJobSelefAssess.setJobSelfId(jobSelf);
			jobSelf.setReJobSelefAssessList(reJobSelefAssessDao.findList(reJobSelefAssess));
			//String sum = jobSelf.getScore();
			String sum = reJobSelefAssessDao.sum(jobSelf.getId());
			if(StringUtils.isNotBlank(sum)){
				jobSelf.setDef1(sum);
				double valueOf = Double.valueOf(sum);
				total+=valueOf;
			}
		}
		DecimalFormat df = new DecimalFormat("0.00");//格式化小数    
        String average = df.format((float)total/dbJobSelfList.size());//返回的是String类型
		//db_assess_index的    及分数
		Map<String,Double> map = new HashMap<String, Double>();
		for(int i=0;i<dbJobSelfList.size();i++){
			List<ReJobSelefAssess> reJobSelefAssessList = dbJobSelfList.get(i).getReJobSelefAssessList();
			if(reJobSelefAssessList.size() == 0){ // 没有评分的
				for(ReQuestionnaireAssess assess : reQAList){
					ReJobSelefAssess jobSelefAssess = new ReJobSelefAssess();
					jobSelefAssess.setAssessId(assess.getAssessId());
					jobSelefAssess.setScore(0);
					reJobSelefAssessList.add(jobSelefAssess);
				}
				dbJobSelfList.get(i).setReJobSelefAssessList(reJobSelefAssessList);
			}
			for(int j=0;j<reJobSelefAssessList.size();j++){
				String id = reJobSelefAssessList.get(j).getAssessId().getId();
				boolean key = map.containsKey(id);
				double score = reJobSelefAssessList.get(j).getScore();
				if(key){
					double integer = map.get(id);
					map.put(id, integer+score);
				}else{
					map.put(id, score);
				}
			}
		}
		List<DbLevel> dbLevelList1 = Lists.newArrayList();      //一级
		List<DbLevel> dbLevelList2 = Lists.newArrayList();		//二级
		List<DbLevel> dbLevelList3 = Lists.newArrayList();		//三级
		List<DbAssessIndex> dbLevelList4 = Lists.newArrayList();//四级（要点）
		List<String> list = new ArrayList();
		int num=0;
		for(ReQuestionnaireAssess assess : reQAList){
			//指标id查指标
			String assessId = assess.getAssessId().getId();
			DbAssessIndex dbAssessIndex = dbAssessIndexDao.get(assessId);
			Double integer = map.get(assessId);
			String format ="";
			if(integer == null){
				format = "0.00";
			}else{
				format = df.format((double)integer/dbJobSelfList.size());//返回的是String类型
			}
	        //前台拿到子表list得下标
			dbAssessIndex.setDef1(num+"");
			dbAssessIndex.setDef4(format);
			num++;
			//三级id查名称
			String levelId = dbAssessIndex.getLevelId().getId();
			list.add(levelId);
			int frequency = Collections.frequency(list, levelId);
			DbLevel dbLevel = dbLevelDao.get(levelId);
			dbLevel.setDef1(frequency+"");
			String parentIds = dbLevel.getParentIds();
			String[] split = parentIds.split(",");
			//一级
			DbLevel dbLevel1 = dbLevelDao.get(split[1]);
			//二级
			DbLevel dbLevel2 = dbLevelDao.get(split[2]);
			if(!dbLevelList1.contains(dbLevel1)){
				dbLevelList1.add(dbLevel1);
			}
			if(!dbLevelList2.contains(dbLevel2)){
				dbLevelList2.add(dbLevel2);
			}
			if(dbLevelList3.contains(dbLevel)){
				dbLevelList3.remove(dbLevel);
				dbLevelList3.add(dbLevel);
			}else{
				dbLevelList3.add(dbLevel);
				
			}
			if(!dbLevelList4.contains(dbAssessIndex)){
				dbLevelList4.add(dbAssessIndex);
			}
		}
		for(int i=0;i<dbLevelList2.size();i++){
			int a = 0;
			for(int j=0;j<dbLevelList3.size();j++){
				if(dbLevelList2.get(i).getId().equals(dbLevelList3.get(j).getParent().getId())){
					String def1 = dbLevelList3.get(j).getDef1();
					int parseInt = Integer.parseInt(def1);
					a+=parseInt;
				}
			}
			dbLevelList2.get(i).setDef1(a+"");
		}
		for(int i=0;i<dbLevelList1.size();i++){
			int a = 0;
			for(int j=0;j<dbLevelList2.size();j++){
				if(dbLevelList1.get(i).getId().equals(dbLevelList2.get(j).getParent().getId())){
					String def1 = dbLevelList2.get(j).getDef1();
					int parseInt = Integer.parseInt(def1);
					a+=parseInt;
				}
			}
			dbLevelList1.get(i).setDef1(a+"");
		}
		model.addAttribute("average", average);
		model.addAttribute("dbJob", dbJob);
		model.addAttribute("dbLevelList1", dbLevelList1);
		model.addAttribute("dbLevelList2", dbLevelList2);
		model.addAttribute("dbLevelList3", dbLevelList3);
		model.addAttribute("dbLevelList4", dbLevelList4);
		model.addAttribute("dbJobSelfList", dbJobSelfList);
		return "modules/assess/dbJobSelfTable";
	}
	@RequiresPermissions("assess:dbJobSelf:view")
	@RequestMapping(value = "table2")
	public String table2(DbJob dbJob, Model model) {
		DbQuestionnaire questionnaireId = dbJob.getQuestionnaireId();   //问卷id
		ReQuestionnaireAssess questionnaireAssess = new ReQuestionnaireAssess();
		questionnaireAssess.setQuestionnaireId(questionnaireId);
		List<ReQuestionnaireAssess> reQAList = reQuestionnaireAssessDao.findList(questionnaireAssess);  //问卷子表  list
		DbJobSelf dbJobSelf = new DbJobSelf();
		dbJobSelf.setJobId(dbJob);
		dbJobSelf.setDef2("2");
		List<DbJobSelf> dbJobSelfList = dbJobSelfDao.findList(dbJobSelf);    //个人任务
		double total = 0;
		for(DbJobSelf jobSelf : dbJobSelfList){
			ReJobSelefAssess reJobSelefAssess = new ReJobSelefAssess();
			reJobSelefAssess.setJobSelfId(jobSelf);
			jobSelf.setReJobSelefAssessList(reJobSelefAssessDao.findList(reJobSelefAssess));
			//String sum = jobSelf.getScore();
			String sum = reJobSelefAssessDao.sum(jobSelf.getId());
			if(StringUtils.isNotBlank(sum)){
				jobSelf.setDef1(sum);
				double valueOf = Double.valueOf(sum);
				total+=valueOf;
			}
		}
		DecimalFormat df = new DecimalFormat("0.00");//格式化小数    
		String average = df.format((float)total/dbJobSelfList.size());//返回的是String类型
		//db_assess_index的    及分数
		Map<String,Double> map = new HashMap<String, Double>();
		for(int i=0;i<dbJobSelfList.size();i++){
			List<ReJobSelefAssess> reJobSelefAssessList = dbJobSelfList.get(i).getReJobSelefAssessList();
			if(reJobSelefAssessList.size() == 0){ // 没有评分的
				for(ReQuestionnaireAssess assess : reQAList){
					ReJobSelefAssess jobSelefAssess = new ReJobSelefAssess();
					jobSelefAssess.setAssessId(assess.getAssessId());
					jobSelefAssess.setScore(0);
					reJobSelefAssessList.add(jobSelefAssess);
				}
				dbJobSelfList.get(i).setReJobSelefAssessList(reJobSelefAssessList);
			}
			for(int j=0;j<reJobSelefAssessList.size();j++){
				String id = reJobSelefAssessList.get(j).getAssessId().getId();
				boolean key = map.containsKey(id);
				double score = reJobSelefAssessList.get(j).getScore();
				if(key){
					double integer = map.get(id);
					map.put(id, integer+score);
				}else{
					map.put(id, score);
				}
			}
		}
		List<DbLevel> dbLevelList1 = Lists.newArrayList();      //一级
		List<DbLevel> dbLevelList2 = Lists.newArrayList();		//二级
		List<DbLevel> dbLevelList3 = Lists.newArrayList();		//三级
		List<DbAssessIndex> dbLevelList4 = Lists.newArrayList();//四级（要点）
		List<String> list = new ArrayList();
		int num=0;
		for(ReQuestionnaireAssess assess : reQAList){
			//指标id查指标
			String assessId = assess.getAssessId().getId();
			DbAssessIndex dbAssessIndex = dbAssessIndexDao.get(assessId);
			Double integer = map.get(assessId);
			String format ="";
			if(integer == null){
				format = "0.00";
			}else{
				format = df.format((double)integer/dbJobSelfList.size());//返回的是String类型
			}
			//前台拿到子表list得下标
			dbAssessIndex.setDef1(num+"");
			dbAssessIndex.setDef4(format);
			num++;
			//三级id查名称
			String levelId = dbAssessIndex.getLevelId().getId();
			list.add(levelId);
			int frequency = Collections.frequency(list, levelId);
			DbLevel dbLevel = dbLevelDao.get(levelId);
			dbLevel.setDef1(frequency+"");
			String parentIds = dbLevel.getParentIds();
			String[] split = parentIds.split(",");
			//一级
			DbLevel dbLevel1 = dbLevelDao.get(split[1]);
			//二级
			DbLevel dbLevel2 = dbLevelDao.get(split[2]);
			if(!dbLevelList1.contains(dbLevel1)){
				dbLevelList1.add(dbLevel1);
			}
			if(!dbLevelList2.contains(dbLevel2)){
				dbLevelList2.add(dbLevel2);
			}
			if(dbLevelList3.contains(dbLevel)){
				dbLevelList3.remove(dbLevel);
				dbLevelList3.add(dbLevel);
			}else{
				dbLevelList3.add(dbLevel);
				
			}
			if(!dbLevelList4.contains(dbAssessIndex)){
				dbLevelList4.add(dbAssessIndex);
			}
		}
		for(int i=0;i<dbLevelList2.size();i++){
			int a = 0;
			for(int j=0;j<dbLevelList3.size();j++){
				if(dbLevelList2.get(i).getId().equals(dbLevelList3.get(j).getParent().getId())){
					String def1 = dbLevelList3.get(j).getDef1();
					int parseInt = Integer.parseInt(def1);
					a+=parseInt;
				}
			}
			dbLevelList2.get(i).setDef1(a+"");
		}
		for(int i=0;i<dbLevelList1.size();i++){
			int a = 0;
			for(int j=0;j<dbLevelList2.size();j++){
				if(dbLevelList1.get(i).getId().equals(dbLevelList2.get(j).getParent().getId())){
					String def1 = dbLevelList2.get(j).getDef1();
					int parseInt = Integer.parseInt(def1);
					a+=parseInt;
				}
			}
			dbLevelList1.get(i).setDef1(a+"");
		}
		model.addAttribute("average", average);
		model.addAttribute("dbJob", dbJob);
		model.addAttribute("dbLevelList1", dbLevelList1);
		model.addAttribute("dbLevelList2", dbLevelList2);
		model.addAttribute("dbLevelList3", dbLevelList3);
		model.addAttribute("dbLevelList4", dbLevelList4);
		model.addAttribute("dbJobSelfList", dbJobSelfList);
		return "modules/assess/dbJobSelfTable2";
	}
	/**
	 * 评语明细表格
	 * @param dbJobSelf
	 * @param model
	 * @return
	 *@author  zsd
	 *@date 2017年9月25日 下午5:31:09
	 */
	@RequiresPermissions("assess:dbJobSelf:view")
	@RequestMapping(value = "comment")
	public String comment(DbJob dbJob, Model model) {
		DbQuestionnaire questionnaireId = dbJob.getQuestionnaireId();   //问卷id
		ReQuestionnaireAssess questionnaireAssess = new ReQuestionnaireAssess();
		questionnaireAssess.setQuestionnaireId(questionnaireId);
		List<ReQuestionnaireAssess> reQAList = reQuestionnaireAssessDao.findList(questionnaireAssess);  //问卷子表  list
		DbJobSelf dbJobSelf = new DbJobSelf();
		dbJobSelf.setJobId(dbJob);
		dbJobSelf.setDef2("2");
		List<DbJobSelf> dbJobSelfList = dbJobSelfDao.findList(dbJobSelf);    //个人任务
		double total = 0;
		for(DbJobSelf jobSelf : dbJobSelfList){
			ReJobSelefAssess reJobSelefAssess = new ReJobSelefAssess();
			reJobSelefAssess.setJobSelfId(jobSelf);
			jobSelf.setReJobSelefAssessList(reJobSelefAssessDao.findList(reJobSelefAssess));
			String sum = reJobSelefAssessDao.sum(jobSelf.getId());
			if(StringUtils.isNotBlank(sum)){
				jobSelf.setDef1(sum);
				double valueOf = Double.valueOf(sum);
				total+=valueOf;
			}
		}
		DecimalFormat df = new DecimalFormat("0.00");//格式化小数    
		String average = df.format((float)total/dbJobSelfList.size());//返回的是String类型
		//db_assess_index的    及分数
		Map<String,Double> map = new HashMap<String, Double>();
		for(int i=0;i<dbJobSelfList.size();i++){
			List<ReJobSelefAssess> reJobSelefAssessList = dbJobSelfList.get(i).getReJobSelefAssessList();
			if(reJobSelefAssessList.size() == 0){ // 没有评分的
				for(ReQuestionnaireAssess assess : reQAList){
					ReJobSelefAssess jobSelefAssess = new ReJobSelefAssess();
					jobSelefAssess.setAssessId(assess.getAssessId());
					jobSelefAssess.setScore(0);
					reJobSelefAssessList.add(jobSelefAssess);
				}
				dbJobSelfList.get(i).setReJobSelefAssessList(reJobSelefAssessList);
			}
			for(int j=0;j<reJobSelefAssessList.size();j++){
				String id = reJobSelefAssessList.get(j).getAssessId().getId();
				boolean key = map.containsKey(id);
				double score = reJobSelefAssessList.get(j).getScore();
				if(key){
					double integer = map.get(id);
					map.put(id, integer+score);
				}else{
					map.put(id, score);
				}
			}
		}
		List<DbLevel> dbLevelList1 = Lists.newArrayList();      //一级
		List<DbLevel> dbLevelList2 = Lists.newArrayList();		//二级
		List<DbLevel> dbLevelList3 = Lists.newArrayList();		//三级
		List<DbAssessIndex> dbLevelList4 = Lists.newArrayList();//四级（要点）
		List<String> list = new ArrayList();
		int num=0;
		for(ReQuestionnaireAssess assess : reQAList){
			//指标id查指标
			String assessId = assess.getAssessId().getId();
			DbAssessIndex dbAssessIndex = dbAssessIndexDao.get(assessId);
			Double integer = map.get(assessId);
			String format ="";
			if(integer == null){
				format = "0.00";
			}else{
				format = df.format((double)integer/dbJobSelfList.size());//返回的是String类型
			}
			//前台拿到子表list得下标
			dbAssessIndex.setDef1(num+"");
			dbAssessIndex.setDef4(format);
			num++;
			//三级id查名称
			String levelId = dbAssessIndex.getLevelId().getId();
			list.add(levelId);
			int frequency = Collections.frequency(list, levelId);
			DbLevel dbLevel = dbLevelDao.get(levelId);
			dbLevel.setDef1(frequency+"");
			String parentIds = dbLevel.getParentIds();
			String[] split = parentIds.split(",");
			//一级
			DbLevel dbLevel1 = dbLevelDao.get(split[1]);
			//二级
			DbLevel dbLevel2 = dbLevelDao.get(split[2]);
			if(!dbLevelList1.contains(dbLevel1)){
				dbLevelList1.add(dbLevel1);
			}
			if(!dbLevelList2.contains(dbLevel2)){
				dbLevelList2.add(dbLevel2);
			}
			if(dbLevelList3.contains(dbLevel)){
				dbLevelList3.remove(dbLevel);
				dbLevelList3.add(dbLevel);
			}else{
				dbLevelList3.add(dbLevel);
				
			}
			if(!dbLevelList4.contains(dbAssessIndex)){
				dbLevelList4.add(dbAssessIndex);
			}
		}
		for(int i=0;i<dbLevelList2.size();i++){
			int a = 0;
			for(int j=0;j<dbLevelList3.size();j++){
				if(dbLevelList2.get(i).getId().equals(dbLevelList3.get(j).getParent().getId())){
					String def1 = dbLevelList3.get(j).getDef1();
					int parseInt = Integer.parseInt(def1);
					a+=parseInt;
				}
			}
			dbLevelList2.get(i).setDef1(a+"");
		}
		for(int i=0;i<dbLevelList1.size();i++){
			int a = 0;
			for(int j=0;j<dbLevelList2.size();j++){
				if(dbLevelList1.get(i).getId().equals(dbLevelList2.get(j).getParent().getId())){
					String def1 = dbLevelList2.get(j).getDef1();
					int parseInt = Integer.parseInt(def1);
					a+=parseInt;
				}
			}
			dbLevelList1.get(i).setDef1(a+"");
		}
		model.addAttribute("average", average);
		model.addAttribute("dbJob", dbJob);
		model.addAttribute("dbLevelList1", dbLevelList1);
		model.addAttribute("dbLevelList2", dbLevelList2);
		model.addAttribute("dbLevelList3", dbLevelList3);
		model.addAttribute("dbLevelList4", dbLevelList4);
		model.addAttribute("dbJobSelfList", dbJobSelfList);
		return "modules/assess/dbJobSelfComment";
	}
	@RequiresPermissions("assess:dbJobSelf:view")
	@RequestMapping(value = "comment2")
	public String comment2(DbJob dbJob, Model model) {
		DbQuestionnaire questionnaireId = dbJob.getQuestionnaireId();   //问卷id
		ReQuestionnaireAssess questionnaireAssess = new ReQuestionnaireAssess();
		questionnaireAssess.setQuestionnaireId(questionnaireId);
		List<ReQuestionnaireAssess> reQAList = reQuestionnaireAssessDao.findList(questionnaireAssess);  //问卷子表  list
		DbJobSelf dbJobSelf = new DbJobSelf();
		dbJobSelf.setJobId(dbJob);
		dbJobSelf.setDef2("2");
		List<DbJobSelf> dbJobSelfList = dbJobSelfDao.findList(dbJobSelf);    //个人任务
		double total = 0;
		for(DbJobSelf jobSelf : dbJobSelfList){
			ReJobSelefAssess reJobSelefAssess = new ReJobSelefAssess();
			reJobSelefAssess.setJobSelfId(jobSelf);
			jobSelf.setReJobSelefAssessList(reJobSelefAssessDao.findList(reJobSelefAssess));
			String sum = reJobSelefAssessDao.sum(jobSelf.getId());
			if(StringUtils.isNotBlank(sum)){
				jobSelf.setDef1(sum);
				double valueOf = Double.valueOf(sum);
				total+=valueOf;
			}
		}
		DecimalFormat df = new DecimalFormat("0.00");//格式化小数    
		String average = df.format((float)total/dbJobSelfList.size());//返回的是String类型
		//db_assess_index的    及分数
		Map<String,Double> map = new HashMap<String, Double>();
		for(int i=0;i<dbJobSelfList.size();i++){
			List<ReJobSelefAssess> reJobSelefAssessList = dbJobSelfList.get(i).getReJobSelefAssessList();
			if(reJobSelefAssessList.size() == 0){ // 没有评分的
				for(ReQuestionnaireAssess assess : reQAList){
					ReJobSelefAssess jobSelefAssess = new ReJobSelefAssess();
					jobSelefAssess.setAssessId(assess.getAssessId());
					jobSelefAssess.setScore(0);
					reJobSelefAssessList.add(jobSelefAssess);
				}
				dbJobSelfList.get(i).setReJobSelefAssessList(reJobSelefAssessList);
			}
			for(int j=0;j<reJobSelefAssessList.size();j++){
				String id = reJobSelefAssessList.get(j).getAssessId().getId();
				boolean key = map.containsKey(id);
				double score = reJobSelefAssessList.get(j).getScore();
				if(key){
					double integer = map.get(id);
					map.put(id, integer+score);
				}else{
					map.put(id, score);
				}
			}
		}
		List<DbLevel> dbLevelList1 = Lists.newArrayList();      //一级
		List<DbLevel> dbLevelList2 = Lists.newArrayList();		//二级
		List<DbLevel> dbLevelList3 = Lists.newArrayList();		//三级
		List<DbAssessIndex> dbLevelList4 = Lists.newArrayList();//四级（要点）
		List<String> list = new ArrayList();
		int num=0;
		for(ReQuestionnaireAssess assess : reQAList){
			//指标id查指标
			String assessId = assess.getAssessId().getId();
			DbAssessIndex dbAssessIndex = dbAssessIndexDao.get(assessId);
			Double integer = map.get(assessId);
			String format ="";
			if(integer == null){
				format = "0.00";
			}else{
				format = df.format((double)integer/dbJobSelfList.size());//返回的是String类型
			}
			//前台拿到子表list得下标
			dbAssessIndex.setDef1(num+"");
			dbAssessIndex.setDef4(format);
			num++;
			//三级id查名称
			String levelId = dbAssessIndex.getLevelId().getId();
			list.add(levelId);
			int frequency = Collections.frequency(list, levelId);
			DbLevel dbLevel = dbLevelDao.get(levelId);
			dbLevel.setDef1(frequency+"");
			String parentIds = dbLevel.getParentIds();
			String[] split = parentIds.split(",");
			//一级
			DbLevel dbLevel1 = dbLevelDao.get(split[1]);
			//二级
			DbLevel dbLevel2 = dbLevelDao.get(split[2]);
			if(!dbLevelList1.contains(dbLevel1)){
				dbLevelList1.add(dbLevel1);
			}
			if(!dbLevelList2.contains(dbLevel2)){
				dbLevelList2.add(dbLevel2);
			}
			if(dbLevelList3.contains(dbLevel)){
				dbLevelList3.remove(dbLevel);
				dbLevelList3.add(dbLevel);
			}else{
				dbLevelList3.add(dbLevel);
				
			}
			if(!dbLevelList4.contains(dbAssessIndex)){
				dbLevelList4.add(dbAssessIndex);
			}
		}
		for(int i=0;i<dbLevelList2.size();i++){
			int a = 0;
			for(int j=0;j<dbLevelList3.size();j++){
				if(dbLevelList2.get(i).getId().equals(dbLevelList3.get(j).getParent().getId())){
					String def1 = dbLevelList3.get(j).getDef1();
					int parseInt = Integer.parseInt(def1);
					a+=parseInt;
				}
			}
			dbLevelList2.get(i).setDef1(a+"");
		}
		for(int i=0;i<dbLevelList1.size();i++){
			int a = 0;
			for(int j=0;j<dbLevelList2.size();j++){
				if(dbLevelList1.get(i).getId().equals(dbLevelList2.get(j).getParent().getId())){
					String def1 = dbLevelList2.get(j).getDef1();
					int parseInt = Integer.parseInt(def1);
					a+=parseInt;
				}
			}
			dbLevelList1.get(i).setDef1(a+"");
		}
		model.addAttribute("average", average);
		model.addAttribute("dbJob", dbJob);
		model.addAttribute("dbLevelList1", dbLevelList1);
		model.addAttribute("dbLevelList2", dbLevelList2);
		model.addAttribute("dbLevelList3", dbLevelList3);
		model.addAttribute("dbLevelList4", dbLevelList4);
		model.addAttribute("dbJobSelfList", dbJobSelfList);
		return "modules/assess/dbJobSelfComment2";
	}

	@RequiresPermissions("assess:dbJob:view")
	@RequestMapping(value = "lnk")
	public String lnk( HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		List<String>  list = new ArrayList<String>();
		String[] strings = user.getRoleNames().split(",");
		for (String string : strings) {
			if (user.isAdmin()) {
//				list.add("1");
//				list.add("2");
//				list.add("3");
//				list.add("4");
//				list.add("5");
//				list.add("6");
				break;
			}else if(string.equals("小组长")){
//				list.add("1");
//				list.add("2");
				list.add("3");
				list.add("4");
//				list.add("5");
//				list.add("6");
			}else if(string.equals("评分人")){
				list.add("1");
				list.add("2");
				list.add("3");
				list.add("4");
//				list.add("5");
//				list.add("6");
			}else if(string.equals("老师")){
				list.add("1");
				list.add("2");
//				list.add("3");
//				list.add("4");
//				list.add("5");
//				list.add("6");
			}else if(string.equals("系统管理员")){
//				list.add("1");
//				list.add("2");
//				list.add("3");
//				list.add("4");
//				list.add("5");
//				list.add("6");
				break;
			}
		}
		
		model.addAttribute("list", list);
		return "modules/assess/index";
	}
	@RequiresPermissions("assess:dbJob:view")
	@RequestMapping(value = "print")
	public String print(DbJob dbJob,String id, Model model) {
		model.addAttribute("id", id);
		model.addAttribute("dbJob", dbJob);
		return "modules/assess/print";
	}

	@RequiresPermissions("assess:dbJob:view")
	@RequestMapping(value = "aa")
	public String aa() {
        System.err.println("输出结果:"+"what fuck!!");
		return "modules/assess/print12";
	}
	
}