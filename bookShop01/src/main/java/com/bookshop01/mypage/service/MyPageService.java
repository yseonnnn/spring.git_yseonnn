package com.bookshop01.mypage.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.bookshop01.member.vo.MemberBean;
import com.bookshop01.mypage.vo.MyPageBean;
import com.bookshop01.order.vo.OrderBean;

public interface MyPageService{
	public ArrayList<OrderBean> listMyOrderGoods(MemberBean memberBean) throws Exception;
	public ArrayList findMyOrderInfo(String order_id) throws Exception;
	public ArrayList<OrderBean> listMyOrderHistory(MyPageBean myPageBean) throws Exception;
	public MemberBean  modifyMyInfo(HashMap memberMap) throws Exception;
	public void cancelOrder(String order_id) throws Exception;
	public MemberBean myInfoDetail(String member_id) throws Exception;

}
