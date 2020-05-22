package mypack;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

/**
 * Servlet implementation class RemoveUserPhotoDomainServlet
 */
@WebServlet("/RemoveUserPhotoDomainServlet")
public class RemoveUserPhotoDomainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoveUserPhotoDomainServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String dn=request.getParameter("ml");
		HttpSession hs=request.getSession();
	
        ModifyDomainRemAtt.modyfyRemAtt(hs, dn, "domainPhoto")	;
        
       
        

		String ip= (String)hs.getAttribute("ip");
		String utype= (String)hs.getAttribute("user_name");
		String adm="";
		if(utype.equals("Admin"))
		{
			adm="Global Admin";
		}
		else
		{
			adm="mail-admin@"+dn;
		}
		String sql="insert into log (ip,name,domain,msg) values(?,?,?,?)";
		String data=ip+","+adm+","+dn+",Edit Domain -Remove photo : "+dn;
		int mg=Crudoperation.insertlog(sql, data);
        response.sendRedirect("/unifiedmail/global/editdomainprofile.jsp?dn="+dn+"&status=succ");
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
