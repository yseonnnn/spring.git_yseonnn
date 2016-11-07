package com.bookshop01.member.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop01.common.controller.BaseController;
import com.bookshop01.member.service.MemberService;
import com.bookshop01.member.vo.MemberBean;

@Controller("memberController")
@RequestMapping(value="/member")
public class MemberControllerImpl  extends BaseController implements MemberController{
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value="/login.do" ,method = RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String member_id=request.getParameter("member_id");
		String member_pw=request.getParameter("member_pw");
		MemberBean memberBean=new MemberBean();
		memberBean.setMember_id(member_id);
		memberBean.setMember_pw(member_pw);
		
		MemberBean member_info=memberService.login(memberBean);
		if(member_info!= null && member_info.getMember_id()!=null){
			HttpSession session=request.getSession();
			session=request.getSession();
			session.setAttribute("isLogOn", new Boolean(true));
			session.setAttribute("member_info",member_info);
			
			String isComeFrom = (String) session.getAttribute("isComeFrom");
			if(isComeFrom!=null && isComeFrom.equals("/order/orderEachGoods.do")) {
				mav.setViewName("forward:" + isComeFrom);
			} else {
				mav.setViewName("redirect:/main/main.do");
			}
		}else{
			String message="로그인에 실패하였습니다.";
			mav.addObject("message", message);
			mav.setViewName("/member/loginForm");
		}
		return mav;
	}
	
	@RequestMapping(value="/logout.do" ,method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		session.setAttribute("isLogOn", new Boolean(false));
		mav.setViewName("redirect:/main/main.do");
		return mav;
	}
	
	@RequestMapping(value="/addMember.do" ,method = RequestMethod.POST)
	public ModelAndView addMember(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();
		MemberBean memberBean=new MemberBean();
		bind(request, memberBean);
					
		memberService.addMember(memberBean);
		mav.setViewName("redirect:/member/loginForm.do");
		return mav;
	}
	
	@RequestMapping(value = "/idOverlapped.do", method = RequestMethod.POST)
	public void idOverlapped(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html charset=utf-8"); 
		
		PrintWriter pw = response.getWriter();	
		String member_id = request.getParameter("member_id");	
		String _member_id = memberService.idOverlapped(member_id);		
		
		if(_member_id!=null && _member_id.length()!=0) {
			pw.print("이미 사용 중인 아이디입니다.");
		} else {
			pw.print("사용 가능한 아이디입니다.");
		}
	}
	
}
