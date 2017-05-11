package net.pack.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.pack.db.PackDAO;

public class PackSearchAction implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		String search = request.getParameter("city");
		String basicSD = request.getParameter("startDate");
		String basicED = request.getParameter("endDate");
		String sD[] = basicSD.split("-");
		String eD[] = basicED.split("-");
		
		int startDate = Integer.parseInt(sD[0] + sD[1] + sD[2]);
		int endDate = Integer.parseInt(eD[0] + eD[1] + eD[2]);
		
		System.out.println("start >> " + startDate);
		System.out.println("end >> " + endDate);
		
		System.out.println("search >> " + search);
		// 디비 객체 생성 BoardDAO
		PackDAO pdao = new PackDAO();
		//전체글 횟수 구하기 int count = getBoardCount()
		int count = pdao.getPackCount(search, startDate, endDate);//pdao.getBoardCount();
		
		System.out.println("count >> " + count);
		//한페이지에 보여줄 글의 갯수
		int pagesize = 6;
		//시작행 구하기   1,  11,  21,  31,  41  ...... 
		
		//현재페이지가 몇페이지인지 가져오기
		String pageNum = request.getParameter("pageNum");
		
		
		if(pageNum == null)
			pageNum = "1";
		
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage-1)*pagesize+1;
		
		
		//끝행 구하기
		int endRow = currentPage*pagesize;	
		
			
		
		// 페이지 갯수 구하기
		int pageCount = count/pagesize + (count%pagesize == 0 ? 0 : 1);
		//한 화면에 보여줄 페이지 번호 갯수
		int pageBlock = 10;
		// 시작 페이지 구하기
		int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
		// 끝페이지 구하기
		int endPage = startPage+pageBlock-1;

//		for(int i = 0; i < area.length; i++)
//		{
//			list[i] = pdao.getBoardList(startRow, pagesize, area[i]);
//		}
		
		List list = pdao.getBoardList_search(startRow, pagesize, search, startDate, endDate);
		
		
		request.setAttribute("list", list);
		request.setAttribute("count", count);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("pageBlock", pageBlock);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("search", search);
		request.setAttribute("startDate", basicSD);
		request.setAttribute("endDate", basicED);
		
		
		//ActoinForward 이동정보 담아서 로그인 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./pack/Package_search.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
