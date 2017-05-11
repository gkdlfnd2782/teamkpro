package net.pack.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.pack.db.PackBean;
import net.pack.db.PackDAO;


public class PackModify implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("PackModify excute()");
		//int num가져오기
		int num = Integer.parseInt(request.getParameter("num"));
		//디비객체 생성 agdao
		PackDAO pdao=new PackDAO();
		//GoodsBean goodsbean = 메서드호출 getGoods(num)
		PackBean pb = pdao.getPack(num);
		//저장 goodsbean
		request.setAttribute("pb", pb);
		//이동 ./admingoods/admin_goods_modify.jsp
		request.setAttribute("num", num);
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./pack/Package_modify.jsp");
		return forward;
	}

}
