package mypack;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ImageCropServlet extends HttpServlet {

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
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		
		int t=Integer.parseInt(req.getParameter("t"));
		int l=Integer.parseInt(req.getParameter("l"));
		int w=Integer.parseInt(req.getParameter("w"));
		int h=Integer.parseInt(req.getParameter("h"));
		String imagePath="/maildir/domains/"+req.getParameter("i")   ;//getServletContext().getRealPath("/")+req.getParameter("i");
		BufferedImage outImage=ImageIO.read(new File(imagePath));
		BufferedImage cropped=outImage.getSubimage(l, t, w, h);
		ByteArrayOutputStream out=new ByteArrayOutputStream();
		ImageIO.write(cropped,req.getParameter("f"), out);

		ImageIO.write(cropped,req.getParameter("f"),
		new File("/maildir/domains"+System.getProperty("file.separator")
				+req.getParameter("i"))); // save the file with crop dimensions
				//new File(getServletContext().getRealPath("")+System.getProperty("file.separator")
				//		+req.getParameter("i")));

		//res.setContentType("image/jpg");
		ServletOutputStream wrt=res.getOutputStream();
		String mail=req.getParameter("hid_mail");
		res.sendRedirect("/unifiedmail/global/edituserprofile.jsp?ml="+mail+"&status=succ"); 
		
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
