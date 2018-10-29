/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.web;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.starsoft.ezicloud.common.config.Global;
import com.starsoft.ezicloud.common.persistence.Page;
import com.starsoft.ezicloud.common.utils.DateUtils;
import com.starsoft.ezicloud.common.utils.IdGen;
import com.starsoft.ezicloud.common.utils.StringUtils;
import com.starsoft.ezicloud.common.utils.excel.ExportExcel;
import com.starsoft.ezicloud.common.web.BaseController;
import com.starsoft.ezicloud.modules.assess.dao.DbAssessIndexDao;
import com.starsoft.ezicloud.modules.assess.dao.DbJobDao;
import com.starsoft.ezicloud.modules.assess.dao.DbLevelDao;
import com.starsoft.ezicloud.modules.assess.dao.DbQuestionnaireDao;
import com.starsoft.ezicloud.modules.assess.dao.DbQuestionnaireSurveyDao;
import com.starsoft.ezicloud.modules.assess.dao.ReJobSelefAssessDao;
import com.starsoft.ezicloud.modules.assess.dao.ReQuestionnaireAssessDao;
import com.starsoft.ezicloud.modules.assess.entity.DbAssessIndex;
import com.starsoft.ezicloud.modules.assess.entity.DbEvaluatingTeamMember;
import com.starsoft.ezicloud.modules.assess.entity.DbJob;
import com.starsoft.ezicloud.modules.assess.entity.DbJobSelf;
import com.starsoft.ezicloud.modules.assess.entity.DbLevel;
import com.starsoft.ezicloud.modules.assess.entity.DbQuestionnaire;
import com.starsoft.ezicloud.modules.assess.entity.DbQuestionnaireSurvey;
import com.starsoft.ezicloud.modules.assess.entity.ReJobSelefAssess;
import com.starsoft.ezicloud.modules.assess.entity.ReQuestionnaireAssess;
import com.starsoft.ezicloud.modules.assess.entity.Test;
import com.starsoft.ezicloud.modules.assess.entity.Type;
import com.starsoft.ezicloud.modules.assess.service.DbJobSelfService;
import com.starsoft.ezicloud.modules.assess.service.DbQuestionnaireSurveyService;
import com.starsoft.ezicloud.modules.assess.utilts.EchartsDate;
import com.starsoft.ezicloud.modules.assess.utilts.EchartsDateUtils;
import com.starsoft.ezicloud.modules.assess.utilts.Element;
import com.starsoft.ezicloud.modules.sys.entity.User;
import com.starsoft.ezicloud.modules.sys.utils.UserUtils;

/**
 * 个人任务Controller
 * @author tcf
 * @version 2017-09-19
 */
@Controller
@RequestMapping(value = "${adminPath}/assess/dbJobSelf")
public class DbJobSelfController extends BaseController {

	@Autowired
	private DbJobSelfService dbJobSelfService;
	@Autowired
	private ReJobSelefAssessDao reJobSelefAssessDao;
	@Autowired
	private DbJobDao dbJobDao;
	@Autowired
	private DbQuestionnaireDao dbQuestionnaireDao;
	@Autowired
	private ReQuestionnaireAssessDao reQuestionnaireAssessDao;
	@Autowired
	private DbLevelDao dbLevelDao;
	@Autowired
	private DbAssessIndexDao dbAssessIndexDao;
	@Autowired
	private DbQuestionnaireSurveyDao dbQuestionnaireSurveyDao;
	@ModelAttribute
	public DbJobSelf get(@RequestParam(required=false) String id) {
		DbJobSelf entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dbJobSelfService.get(id);
		}
		if (entity == null){
			entity = new DbJobSelf();
		}
		return entity;
	}
	
	@RequiresPermissions("assess:dbJobSelf:view")
	@RequestMapping(value = {"list", ""})
	public String list(DbJobSelf dbJobSelf, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DbJobSelf> page = dbJobSelfService.findPage(new Page<DbJobSelf>(request, response), dbJobSelf); 
		
		model.addAttribute("page", page);
		return "modules/assess/dbJobSelfList";
	}
	/**
	 * 雷达图
	 * @param jobid
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 *@author  zhou
	 *@date 2017年10月11日 下午2:26:20
	 */
	@RequiresPermissions("assess:dbJobSelf:view")
	@RequestMapping(value = {"echarts", ""})
	public String echarts( String jobid,HttpServletRequest request, HttpServletResponse response, Model model) {

		//任务
		DbJob dbJob = dbJobDao.get(jobid);
		List<DbEvaluatingTeamMember> dbEvaluatingTeamMemberList = dbJob.getTeamId().getDbEvaluatingTeamMemberList();
		List<String> users = new ArrayList<String>();
		for(DbEvaluatingTeamMember user:dbEvaluatingTeamMemberList){
			users.add(user.getId());
		}
		//问卷
		DbQuestionnaire questionnaireId = dbJob.getQuestionnaireId();
		//个人任务
		
		DbJobSelf dbJobSelf  =new DbJobSelf();
		dbJobSelf.setJobId(dbJob);
		dbJobSelf.setDef2("2");
		List<DbJobSelf> DbJobSelfList = dbJobSelfService.findList(dbJobSelf);
		
		List<EchartsDate> ld = new ArrayList<EchartsDate>();
		for(DbJobSelf jobself :DbJobSelfList){
			ReJobSelefAssess reJobSelefAssess = new ReJobSelefAssess();
			reJobSelefAssess.setJobSelfId(jobself);
			List<ReJobSelefAssess> reJobSelefAssessList = reJobSelefAssessDao.findList(reJobSelefAssess);
			
			EchartsDate date = new EchartsDate();
			date.setName(jobself.getParticipant().getName());
			List<Element> le = new ArrayList<Element>();
			Map<String,Map<String,Double>> p = new HashMap<String, Map<String,Double>>();
			List<String> list = new ArrayList();
			Map<String,Double> map = new HashMap<String, Double>();
			for(ReJobSelefAssess rejobselefassess:reJobSelefAssessList){
				Map<String,Double> map1 = new HashMap<String, Double>();
				DbAssessIndex assessIndex = rejobselefassess.getAssessId();//指标
				double score = rejobselefassess.getScore();     //分数
				String levelId = dbAssessIndexDao.get(assessIndex).getLevelId().getId();  //三级id
				String parentIds = dbLevelDao.get(levelId).getParentIds();
				String[] split = parentIds.split(",");
				list.add(levelId);
				boolean c = p.containsKey(split[2]);    //判断是否包含指定的键值
			    if(c){
			    	Map<String, Double> map2 = p.get(split[2]);
			    	boolean contains = map2.containsKey(levelId);    //判断是否包含指定的键值
					if(contains) {         //如果条件为真
						double integer = map2.get(levelId);
				       map2.put(levelId, integer+score);
				       p.put(split[2], map2);
				    }else {
				       map2.put(levelId, score);
				       p.put(split[2], map2);
				    }
			    }else{
					   map1.put(levelId, score);
					   p.put(split[2], map1);
			    }
			}
			for(String k : p.keySet()){
				DbLevel dbLevel = dbLevelDao.get(k);  //二级
				DbLevel level = dbLevelDao.get(dbLevel.getParentId());  //一级
				double a = 0;
				int b = 0;
				Map<String, Double> map2 = p.get(k);
				for(String key : map2.keySet()) { 
					a+=map2.get(key);
					b+=Collections.frequency(list, key);
				} 
				Element element = new Element();
				element.setK("一级\t:\t"+level.getName()+"\n"+"二级\t:\t"+dbLevel.getName());
				element.setV1(a/b);
				element.setM(5);
				le.add(element);
				
			}
			date.setList(le);
			ld.add(date);
		}
/*		for(DbJobSelf jobself :DbJobSelfList){
			ReJobSelefAssess reJobSelefAssess = new ReJobSelefAssess();
			reJobSelefAssess.setJobSelfId(jobself);
			List<ReJobSelefAssess> reJobSelefAssessList = reJobSelefAssessDao.findList(reJobSelefAssess);
			
			EchartsDate date = new EchartsDate();
			date.setName(jobself.getParticipant().getName());
			List<Element> le = new ArrayList<Element>();
			for(ReJobSelefAssess rejobselefassess:reJobSelefAssessList){
				DbAssessIndex assessIndex = rejobselefassess.getAssessId();//指标
				int score = rejobselefassess.getScore();
				Element element = new Element();
				element.setK(dbAssessIndexDao.get(assessIndex).getContent());
				element.setV(score);
				element.setM(5);
				le.add(element);
			}
			date.setList(le);
			ld.add(date);
		}
*/		
		
		List<String> legend = EchartsDateUtils.getLegend(ld);
		model.addAttribute("legend", legend);//legend
		List<Map<String, Object>> indicator = EchartsDateUtils.getIndicator(ld);
		model.addAttribute("indicator", indicator);//indicator
		List<Map<String, Object>> series = EchartsDateUtils.getSeries(ld,"1");
		model.addAttribute("series", series);//series
		model.addAttribute("jobid", jobid);//jobid
		model.addAttribute("dbJob", dbJob);//jobid
		return "modules/assess/echarts";
	}
	@RequiresPermissions("assess:dbJobSelf:view")
	@RequestMapping(value = {"echarts2"})
	public String echarts2( String jobid,HttpServletRequest request, HttpServletResponse response, Model model) {
		
		//任务
		DbJob dbJob = dbJobDao.get(jobid);
		List<DbEvaluatingTeamMember> dbEvaluatingTeamMemberList = dbJob.getTeamId().getDbEvaluatingTeamMemberList();
		List<String> users = new ArrayList<String>();
		for(DbEvaluatingTeamMember user:dbEvaluatingTeamMemberList){
			users.add(user.getId());
		}
		//问卷
		DbQuestionnaire questionnaireId = dbJob.getQuestionnaireId();
		//个人任务
		
		DbJobSelf dbJobSelf  =new DbJobSelf();
		dbJobSelf.setJobId(dbJob);
		dbJobSelf.setDef2("2");
		List<DbJobSelf> DbJobSelfList = dbJobSelfService.findList(dbJobSelf);
		
		List<EchartsDate> ld = new ArrayList<EchartsDate>();
		for(DbJobSelf jobself :DbJobSelfList){
			ReJobSelefAssess reJobSelefAssess = new ReJobSelefAssess();
			reJobSelefAssess.setJobSelfId(jobself);
			List<ReJobSelefAssess> reJobSelefAssessList = reJobSelefAssessDao.findList(reJobSelefAssess);
			
			EchartsDate date = new EchartsDate();
			date.setName(jobself.getParticipant().getName());
			List<Element> le = new ArrayList<Element>();
			Map<String,Map<String,Double>> p = new HashMap<String, Map<String,Double>>();
			List<String> list = new ArrayList();
			Map<String,Double> map = new HashMap<String, Double>();
			for(ReJobSelefAssess rejobselefassess:reJobSelefAssessList){
				Map<String,Double> map1 = new HashMap<String, Double>();
				DbAssessIndex assessIndex = rejobselefassess.getAssessId();//指标
				double score = rejobselefassess.getScore();     //分数
				String levelId = dbAssessIndexDao.get(assessIndex).getLevelId().getId();  //三级id
				String parentIds = dbLevelDao.get(levelId).getParentIds();
				String[] split = parentIds.split(",");
				list.add(levelId);
				boolean c = p.containsKey(split[2]);    //判断是否包含指定的键值
				if(c){
					Map<String, Double> map2 = p.get(split[2]);
					boolean contains = map2.containsKey(levelId);    //判断是否包含指定的键值
					if(contains) {         //如果条件为真
						double integer = map2.get(levelId);
						map2.put(levelId, integer+score);
						p.put(split[2], map2);
					}else {
						map2.put(levelId, score);
						p.put(split[2], map2);
					}
				}else{
					map1.put(levelId, score);
					p.put(split[2], map1);
				}
			}
			for(String k : p.keySet()){
				DbLevel dbLevel = dbLevelDao.get(k);  //二级
				DbLevel level = dbLevelDao.get(dbLevel.getParentId());  //一级
				double a = 0;
				int b = 0;
				Map<String, Double> map2 = p.get(k);
				for(String key : map2.keySet()) { 
					a+=map2.get(key);
					b+=Collections.frequency(list, key);
				} 
				Element element = new Element();
				element.setK("一级\t:\t"+level.getName()+"\n"+"二级\t:\t"+dbLevel.getName());
				element.setV1(a/b);
				element.setM(5);
				le.add(element);
				
			}
			date.setList(le);
			ld.add(date);
		}
		/*		for(DbJobSelf jobself :DbJobSelfList){
			ReJobSelefAssess reJobSelefAssess = new ReJobSelefAssess();
			reJobSelefAssess.setJobSelfId(jobself);
			List<ReJobSelefAssess> reJobSelefAssessList = reJobSelefAssessDao.findList(reJobSelefAssess);
			
			EchartsDate date = new EchartsDate();
			date.setName(jobself.getParticipant().getName());
			List<Element> le = new ArrayList<Element>();
			for(ReJobSelefAssess rejobselefassess:reJobSelefAssessList){
				DbAssessIndex assessIndex = rejobselefassess.getAssessId();//指标
				int score = rejobselefassess.getScore();
				Element element = new Element();
				element.setK(dbAssessIndexDao.get(assessIndex).getContent());
				element.setV(score);
				element.setM(5);
				le.add(element);
			}
			date.setList(le);
			ld.add(date);
		}
		 */		
		
		List<String> legend = EchartsDateUtils.getLegend(ld);
		model.addAttribute("legend", legend);//legend
		List<Map<String, Object>> indicator = EchartsDateUtils.getIndicator(ld);
		model.addAttribute("indicator", indicator);//indicator
		List<Map<String, Object>> series = EchartsDateUtils.getSeries(ld,"1");
		model.addAttribute("series", series);//series
		model.addAttribute("jobid", jobid);//jobid
		model.addAttribute("dbJob", dbJob);//jobid
		return "modules/assess/echarts2";
	}
	/**
	 * 柱形（明细图）
	 * @param jobid
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 *@author  zhou
	 *@date 2017年10月11日 下午2:44:38
	 */
	@RequiresPermissions("assess:dbJobSelf:view")
	@RequestMapping(value = {"echartsy", ""})
	public String echartsy( String jobid,HttpServletRequest request, HttpServletResponse response, Model model) {
		
		//任务
		DbJob dbJob = dbJobDao.get(jobid);
		List<DbEvaluatingTeamMember> dbEvaluatingTeamMemberList = dbJob.getTeamId().getDbEvaluatingTeamMemberList();
		List<String> users = new ArrayList<String>();
		for(DbEvaluatingTeamMember user:dbEvaluatingTeamMemberList){
			users.add(user.getId());
		}
		//问卷
		DbQuestionnaire assessId = dbJob.getQuestionnaireId();
		ReQuestionnaireAssess reQuestionnaireAssess = new ReQuestionnaireAssess();
		reQuestionnaireAssess.setQuestionnaireId(assessId);
		List<ReQuestionnaireAssess> list = reQuestionnaireAssessDao.findList(reQuestionnaireAssess);
		List<String> ll = new ArrayList<String>();
		for (ReQuestionnaireAssess reQuestionnaireAssess2 : list) {
			ll.add(dbAssessIndexDao.get(reQuestionnaireAssess2.getAssessId().getId()).getContent());
		}
		//个人任务
		
		DbJobSelf dbJobSelf  =new DbJobSelf();
		dbJobSelf.setJobId(dbJob);
		dbJobSelf.setDef2("2");
		List<DbJobSelf> DbJobSelfList = dbJobSelfService.findList(dbJobSelf);
		List<EchartsDate> ld = new ArrayList<EchartsDate>();
		for(DbJobSelf jobself :DbJobSelfList){
			ReJobSelefAssess reJobSelefAssess = new ReJobSelefAssess();
			reJobSelefAssess.setJobSelfId(jobself);
			List<ReJobSelefAssess> reJobSelefAssessList = reJobSelefAssessDao.findList(reJobSelefAssess);
			
			EchartsDate date = new EchartsDate();
			date.setName(jobself.getParticipant().getName());
			List<Element> le = new ArrayList<Element>();
			for(ReJobSelefAssess rejobselefassess:reJobSelefAssessList){
				DbAssessIndex assessIndex = rejobselefassess.getAssessId();//指标
				double score = rejobselefassess.getScore();
				Element element = new Element();
				element.setK(dbAssessIndexDao.get(assessIndex).getContent());
				element.setV(score);
//				element.setM(5);
				le.add(element);
			}
			date.setList(le);
			ld.add(date);
		}
		
		//指标     getIndicator    <element>
		
		List<Object> vlist = new ArrayList<Object>();//数据集
		Map<Integer, Object> map2 = new HashMap<Integer, Object>();//位置,数据
		List<Map<String, Object>> avg = dbJobDao.avg(jobid);
		for (Map<String,Object> m : avg){
			int indexOf = 0;
			Object object = null;
		      for (String  k : m.keySet()){
		    	  if(k.equals("name")){
		    		  indexOf = ll.indexOf(m.get(k)); //位置
		    	  }
		    	  if(k.equals("avg")){
		    		  object = m.get(k);
		    	  }
		      }
		      map2.put(indexOf, object);
		}
		for(int i=0;i<ll.size();i++){
			if(map2.containsKey(i)){
				vlist.add(map2.get(i));
			}else{
				vlist.add(null);
			}
		}
		List<String> legend = EchartsDateUtils.getLegend(ld);
		legend.add("平均数");
		model.addAttribute("legend", legend);//legend
		Map<String, Object> yAxis = EchartsDateUtils.getyAxis(ll, "category", null);
		model.addAttribute("yAxis", yAxis);//yAxis
		List<Map<String, Object>> series = EchartsDateUtils.getSeries2(ld,"bar",ll,"0");
		Map<String,Object> mm = new HashMap<String, Object>();
		mm.put("name", "平均数");
		mm.put("type", "line");
		mm.put("data", vlist);
		series.add(mm);
		model.addAttribute("series", series);//series
		model.addAttribute("jobid", jobid);//jobid
		model.addAttribute("dbJob", dbJob);//jobid
		return "modules/assess/echarts_bar-y-category";
	}
	@RequiresPermissions("assess:dbJobSelf:view")
	@RequestMapping(value = {"echartsy2"})
	public String echartsy2( String jobid,HttpServletRequest request, HttpServletResponse response, Model model) {
		
		//任务
		DbJob dbJob = dbJobDao.get(jobid);
		List<DbEvaluatingTeamMember> dbEvaluatingTeamMemberList = dbJob.getTeamId().getDbEvaluatingTeamMemberList();
		List<String> users = new ArrayList<String>();
		for(DbEvaluatingTeamMember user:dbEvaluatingTeamMemberList){
			users.add(user.getId());
		}
		//问卷
		DbQuestionnaire assessId = dbJob.getQuestionnaireId();
		ReQuestionnaireAssess reQuestionnaireAssess = new ReQuestionnaireAssess();
		reQuestionnaireAssess.setQuestionnaireId(assessId);
		List<ReQuestionnaireAssess> list = reQuestionnaireAssessDao.findList(reQuestionnaireAssess);
		List<String> ll = new ArrayList<String>();
		for (ReQuestionnaireAssess reQuestionnaireAssess2 : list) {
			ll.add(dbAssessIndexDao.get(reQuestionnaireAssess2.getAssessId().getId()).getContent());
		}
		//个人任务
		
		DbJobSelf dbJobSelf  =new DbJobSelf();
		dbJobSelf.setJobId(dbJob);
		dbJobSelf.setDef2("2");
		List<DbJobSelf> DbJobSelfList = dbJobSelfService.findList(dbJobSelf);
		List<EchartsDate> ld = new ArrayList<EchartsDate>();
		for(DbJobSelf jobself :DbJobSelfList){
			ReJobSelefAssess reJobSelefAssess = new ReJobSelefAssess();
			reJobSelefAssess.setJobSelfId(jobself);
			List<ReJobSelefAssess> reJobSelefAssessList = reJobSelefAssessDao.findList(reJobSelefAssess);
			
			EchartsDate date = new EchartsDate();
			date.setName(jobself.getParticipant().getName());
			List<Element> le = new ArrayList<Element>();
			for(ReJobSelefAssess rejobselefassess:reJobSelefAssessList){
				DbAssessIndex assessIndex = rejobselefassess.getAssessId();//指标
				double score = rejobselefassess.getScore();
				Element element = new Element();
				element.setK(dbAssessIndexDao.get(assessIndex).getContent());
				element.setV(score);
//				element.setM(5);
				le.add(element);
			}
			date.setList(le);
			ld.add(date);
		}
		
		//指标     getIndicator    <element>
		
		List<Object> vlist = new ArrayList<Object>();//数据集
		Map<Integer, Object> map2 = new HashMap<Integer, Object>();//位置,数据
		List<Map<String, Object>> avg = dbJobDao.avg(jobid);
		for (Map<String,Object> m : avg){
			int indexOf = 0;
			Object object = null;
			for (String  k : m.keySet()){
				if(k.equals("name")){
					indexOf = ll.indexOf(m.get(k)); //位置
				}
				if(k.equals("avg")){
					object = m.get(k);
				}
			}
			map2.put(indexOf, object);
		}
		for(int i=0;i<ll.size();i++){
			if(map2.containsKey(i)){
				vlist.add(map2.get(i));
			}else{
				vlist.add(null);
			}
		}
		List<String> legend = EchartsDateUtils.getLegend(ld);
		legend.add("平均数");
		model.addAttribute("legend", legend);//legend
		Map<String, Object> yAxis = EchartsDateUtils.getyAxis(ll, "category", null);
		model.addAttribute("yAxis", yAxis);//yAxis
		List<Map<String, Object>> series = EchartsDateUtils.getSeries2(ld,"bar",ll,"0");
		Map<String,Object> mm = new HashMap<String, Object>();
		mm.put("name", "平均数");
		mm.put("type", "line");
		mm.put("data", vlist);
		series.add(mm);
		model.addAttribute("series", series);//series
		model.addAttribute("jobid", jobid);//jobid
		model.addAttribute("dbJob", dbJob);//jobid
		return "modules/assess/echarts_bar-y-category2";
	}
	

	@RequiresPermissions("assess:dbJobSelf:view")
	@RequestMapping(value = "form")
	public String form(DbJobSelf dbJobSelf, Model model) {
		model.addAttribute("dbJobSelf", dbJobSelf);
		return "modules/assess/dbJobSelfForm";
	}
	/**
	 * 跳转评分页面
	 * @param dbJobSelf
	 * @param model
	 * @return
	 *@author  zsd
	 *@date 2017年9月20日 下午2:38:43
	 */
	@RequiresPermissions("assess:dbJobSelf:view")
	@RequestMapping(value = "exercise")
	public String exercise(DbJobSelf dbJobSelf, Model model) {
			Date startDate = dbJobSelf.getStartDate();
			Date endDate = dbJobSelf.getEndDate();
			Date time = new Date();
			Calendar date = Calendar.getInstance();  //当前
	        date.setTime(time);
	        Calendar after = Calendar.getInstance(); //开始
	        after.setTime(startDate);
	        Calendar before = Calendar.getInstance(); //结束
	        before.setTime(endDate);
	        if(date.after(after) && date.before(before)) {
	            dbJobSelf.setIsAssess("0");
	        }else{
	            dbJobSelf.setIsAssess("1");
	        }
			
		//任务id
		String id = dbJobSelf.getJobId().getId();
		//查到问卷id
		DbJob dbJob = dbJobDao.get(id);
		String questionnaireId = dbJob.getQuestionnaireId().getId();
		//查到问卷和指标
		DbQuestionnaire dbQuestionnaire = dbQuestionnaireDao.get(questionnaireId);
		ReQuestionnaireAssess reQuestionnaireAssess = new ReQuestionnaireAssess();
		reQuestionnaireAssess.setQuestionnaireId(dbQuestionnaire);
		dbQuestionnaire.setReQuestionnaireAssessList(reQuestionnaireAssessDao.findList(reQuestionnaireAssess));
		List<DbLevel> dbLevelList1 = Lists.newArrayList();
		List<DbLevel> dbLevelList2 = Lists.newArrayList();
		List<DbLevel> dbLevelList3 = Lists.newArrayList();
		List<DbAssessIndex> dbLevelList4 = Lists.newArrayList();
		List<String> list = new ArrayList();
		int num=0;
		if(StringUtils.isNotBlank(dbJobSelf.getDef2())){
			ReJobSelefAssess reJobSelefAssess = new ReJobSelefAssess();
			reJobSelefAssess.setJobSelfId(dbJobSelf);
			dbJobSelf.setReJobSelefAssessList(reJobSelefAssessDao.findList(reJobSelefAssess));
		}
		for(ReQuestionnaireAssess reQuestionnaireAssess1 : dbQuestionnaire.getReQuestionnaireAssessList()){
			
			//指标id查指标
			String assessId = reQuestionnaireAssess1.getAssessId().getId();
			DbAssessIndex dbAssessIndex = dbAssessIndexDao.get(assessId);
			
			//前台拿到子表list得下标
			dbAssessIndex.setDef1(num+"");
			num++;
			if(StringUtils.isNotBlank(dbJobSelf.getDef2())){
				for(ReJobSelefAssess assess : dbJobSelf.getReJobSelefAssessList()){
					if(assessId.equals(assess.getAssessId().getId())){
						//前台需要回显得分值及id\评论
						dbAssessIndex.setDef2(assess.getScore()+"");
						dbAssessIndex.setDef3(assess.getId());
						dbAssessIndex.setDef4(assess.getRemarks());
					}
				}
			}
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
		
		DbQuestionnaireSurvey dbQuestionnaireSurvey = new DbQuestionnaireSurvey();
		dbQuestionnaireSurvey.setCreateBy(dbJobSelf.getTarget());
		 List<DbQuestionnaireSurvey> list2 = dbQuestionnaireSurveyDao.findList(dbQuestionnaireSurvey);
		 if (list2.size()>0) {
			 model.addAttribute("QuestionnaireSurvey", "have");
		}else {
			model.addAttribute("QuestionnaireSurvey", "no");
			
		}
		 
		 String def5 = dbJob.getDef5();
		
		model.addAttribute("dbLevelList1", dbLevelList1);
		model.addAttribute("dbLevelList2", dbLevelList2);
		model.addAttribute("dbLevelList3", dbLevelList3);
		model.addAttribute("dbLevelList4", dbLevelList4);
		model.addAttribute("dbQuestionnaire", dbQuestionnaire);
		model.addAttribute("dbJobSelf", dbJobSelf);
		model.addAttribute("def5", def5);
		model.addAttribute("score", dbQuestionnaire.getReQuestionnaireAssessList().size()*5);
		return "modules/assess/dbJobSelfExam";
	}

	@RequiresPermissions("assess:dbJobSelf:view")
	@RequestMapping(value = "detail")
	public String detail(DbJobSelf dbJobSelf, Model model) {
		model.addAttribute("dbJobSelf", dbJobSelf);
		return "modules/assess/dbJobSelfDetail";
	}

	@RequiresPermissions("assess:dbJobSelf:edit")
	@RequestMapping(value = "save")
	public String save(DbJobSelf dbJobSelf, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, dbJobSelf)){
			return form(dbJobSelf, model);
		}
		dbJobSelfService.save(dbJobSelf);
		addMessage(redirectAttributes, "保存个人任务成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbJobSelf/?repage";
	}
	/**
	 * 评分保存
	 * @param dbJobSelf
	 * @param model
	 * @param redirectAttributes
	 * @return
	 *@author  zsd
	 *@date 2017年9月22日 上午11:28:08
	 */
	@RequiresPermissions("assess:dbJobSelf:edit")
	@RequestMapping(value = "saveJobSelf")
	@ResponseBody
	public String saveJobSelf(DbJobSelf dbJobSelf, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, dbJobSelf)){
			return form(dbJobSelf, model);
		}
		String flag;
		try {
			
			double score = 0;
			for(ReJobSelefAssess jobSelefAssess : dbJobSelf.getReJobSelefAssessList()){
				if(StringUtils.isBlank(jobSelefAssess.getId())){
					jobSelefAssess.setId(IdGen.uuid());
					jobSelefAssess.setAssessId(jobSelefAssess.getAssessId());
					jobSelefAssess.setJobSelfId(dbJobSelf);
					jobSelefAssess.setCreateBy(UserUtils.getUser());
					jobSelefAssess.setUpdateBy(UserUtils.getUser());
					jobSelefAssess.setCreateDate(new Date());
					jobSelefAssess.setUpdateDate(new Date());
					reJobSelefAssessDao.insert(jobSelefAssess);
				}else{
					jobSelefAssess.setAssessId(jobSelefAssess.getAssessId());
					jobSelefAssess.setJobSelfId(dbJobSelf);
					jobSelefAssess.setCreateBy(UserUtils.getUser());
					jobSelefAssess.setUpdateBy(UserUtils.getUser());
					jobSelefAssess.setCreateDate(new Date());
					jobSelefAssess.setUpdateDate(new Date());
					reJobSelefAssessDao.update(jobSelefAssess);
				}
				score += jobSelefAssess.getScore();
				
			}
			dbJobSelf.setScore(score+"");
			dbJobSelfService.save(dbJobSelf);
			flag = "true";
		} catch (Exception e) {
			// TODO: handle exception
			flag = "false";
		}
		addMessage(redirectAttributes, "评分成功");
		return flag;
	}
	
	@RequiresPermissions("assess:dbJobSelf:edit")
	@RequestMapping(value = "delete")
	public String delete(DbJobSelf dbJobSelf, RedirectAttributes redirectAttributes) {
		dbJobSelfService.delete(dbJobSelf);
		addMessage(redirectAttributes, "删除个人任务成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbJobSelf/?repage";
	}
	
	@RequiresPermissions("assess:dbJobSelf:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(DbJobSelf dbJobSelf, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "个人任务" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<DbJobSelf> page = dbJobSelfService.findPage(new Page<DbJobSelf>(request, response, -1), dbJobSelf);
			// 解决firefox下载中文无法显示的问题
			String UserAgent = request.getHeader("USER-AGENT").toLowerCase();
			new ExportExcel("个人任务", DbJobSelf.class).setDataList(page.getList()).write(response, fileName, !UserAgent.contains("firefox")).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出个人任务失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/assess/dbJobSelf/list?repage";
	}
	
	@RequiresPermissions("assess:dbJobSelf:view")
	@RequestMapping(value = "reference", method = RequestMethod.POST)
	public String selectList(DbJobSelf dbJobSelf, HttpServletRequest request, HttpServletResponse response, Model model) {
		list(dbJobSelf, request, response, model);
		return "modules/assess/dbJobSelfReferenceList";
	}

	public static void main(String[] args) {
		double l = 0.0;
		l+=1.5;
		System.out.println(l);
	}
}