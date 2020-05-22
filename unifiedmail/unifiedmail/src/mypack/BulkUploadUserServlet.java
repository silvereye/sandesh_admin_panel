package mypack;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BulkUploadUserServlet extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String dm=request.getParameter("dm");
		HttpSession hs=request.getSession();
		int  dqt=CheckValue.valDomainAtt(hs,dm,"domainDefaultUserQuota");
		String fname=request.getParameter("file");
	
	    String path1=getServletContext().getRealPath("/"); 
	    String nwpath=path1+"CsvFile";   
	   String fnl=nwpath+"/"+fname;
	   String str=CsvFileData.getFileData(fnl);
			
	   if(str.equalsIgnoreCase("empty"))
	   {
	   System.out.print("File is empty");
	   }
	   else
	   {
	   
	   
		   if(str!=null)
			{
	        str=str.trim();
			}
			String a[]=str.split(";");
		
		
			 int k=a.length;
				int flg=1;
				String allmail="";
				String uniq_dn="";
				long qt_max=0;
				long usr_max=0;
				long usr_c=0;
				long qt_c=0;
				for(int i=0;i<k;i++)
				{
		       
		        String fn="";
		        String ftn="";
		        String ln="";
		        String pass="";
		        String mail="";
		        String qt=""+dqt;
		       
					//out.print("<br>"+i);
					String b[]=a[i].split(",");
					for(int j=0;j<b.length;j++)
					{
						if(j==0)
						{
							ftn=b[j];
							//dm=dm.toLowerCase();
						}else if(j==1)
						{
							ln=b[j];
							fn=ftn+" "+b[j];
						}
						else if(j==2)
						{ 
							mail=b[j];
							mail=mail.toLowerCase();
							mail=mail.trim();
							
						}else if(j==3)
						{
							pass=b[j];
						}
					}
					
					String mcolor="none";
					String domcolor="none";
					String divcolor="#B5C2C3";
					String mailtit="Email id is correct.";
					String outit="Group is correct.";
					String divtit="Record is Correct";
					String idcolor="";
					String idtit="";
					int rep=0;
					int id=0,m=0,am=0,gp=0;
					int inrec=1;
					
					if(ftn.equals("") || ln.equals("") || pass.equals("") || mail.equals("") )
					{
					inrec=0;
					divcolor="#FF77FF";
					divtit="Improper record";
					}
					else	 
					{
					int qtflg=1;
					/*for(int iq=0;iq<qt.length();iq++)
					{
					int c=(int)(qt.charAt(iq));
					if(c>57 || c<48)
						{
						qtflg=0;
						break;
						}
					}*/
				//	HttpSession hs=request.getSession();
					int dom=CheckValue.checkDomain(hs,dm);
					
					if(dom==1 && uniq_dn.equals(""))
					{
					uniq_dn=dm;
					qt_max=CheckValue.valDomainAttLong(hs,dm,"domainMaxQuotaSize");
					qt_c=CheckValue.valDomainAttLong(hs,dm,"domainCurrentQuotaSize");
					usr_max=CheckValue.valDomainAttLong(hs,dm,"domainMaxUserNumber");
					usr_c=CheckValue.valDomainAttLong(hs,dm,"domainCurrentUserNumber");
					}
					if(qtflg==0 || (mail.indexOf("@")<0)|| dom==0 || !(uniq_dn.equals(dm)))
					{
					inrec=0;
					divcolor="#FF77FF";
					divtit="Improper record";
					}
					else
					{
					if(dom==1)
					{
					qt_c=qt_c+Integer.parseInt(qt);
					usr_c=usr_c+1;
					if(qt_max!=0 && qt_c>qt_max)
					{
					divcolor="#987699";
					divtit="Exceed quota limit";
					usr_c--;
					}
					else if(usr_c> usr_max)
					{
					divcolor="#7CEEDA";
					divtit="Exceed user limit";
					qt_c=qt_c-Integer.parseInt(qt);
					}
					else
					{
					int min=mail.indexOf("@");
					mail=mail.substring(0,min+1)+dm;
				//	CheckUid cu=new  CheckUid();
				     int chk_id=CheckValue.checkUserMail(hs,dm,mail);
					
					if(chk_id==1)
					{
				    divcolor="pink";
					idcolor="red";
					idtit="Mail id is already esixt.";
					divtit="Esixting Records.";
					usr_c--;
					qt_c=qt_c-Integer.parseInt(qt);
					}
					
					
					if(allmail.indexOf(mail)>=0)
					{
					rep=1;
					 divcolor="#aaddaa";
					idcolor="red";
					idtit="Mail id is repeated.";
					divtit="Repeated Records.";
					usr_c--;
					qt_c=qt_c-Integer.parseInt(qt);
					}
					allmail=allmail+","+mail;
					
				
				
				
				
				
			}	
			}
			}
			}	
					
					if(divcolor.equalsIgnoreCase("#B5C2C3")) 
				      {
						
						int f=AddUser.addUser(hs, dm,ftn,ln, mail, qt, pass);
						
				      }
				}
	   }	      					
			response.sendRedirect("/unifiedmail/global/dashboard.jsp");		
		
		out.flush();
		out.close();
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out
				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the POST method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

}
