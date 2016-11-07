package com.bookshop01.admin.member.service;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bookshop01.admin.goods.dao.AdminGoodsDao;
import com.bookshop01.admin.member.dao.AdminMemberDao;
import com.bookshop01.goods.vo.GoodsBean;
import com.bookshop01.goods.vo.ImageFileBean;
import com.bookshop01.member.vo.MemberBean;
import com.bookshop01.order.vo.OrderBean;


@Service("adminMemberService")
@Transactional(propagation=Propagation.REQUIRED)
public class AdminMemberServiceImpl implements AdminMemberService {
	@Autowired
	AdminMemberDao adminMemberDao;
	public ArrayList<MemberBean> listMember(HashMap condMap) throws Exception{
		return adminMemberDao.listMember(condMap);
	}

	public MemberBean memberDetail(String member_id) throws Exception{
		 return adminMemberDao.memberDetail(member_id);
	}
	
	public void  modifyMemberInfo(HashMap memberMap) throws Exception{
		 String member_id=(String)memberMap.get("member_id");
		 adminMemberDao.modifyMemberInfo(memberMap);
	}
}
