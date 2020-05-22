package mypack;

import javax.servlet.http.HttpSession;

public class RemMemGroup {

	public static int remMemOfGroup(HttpSession hs,String lstid,String mail)
	{
		int flg=0;
		String username= (String)hs.getAttribute("id");
        String password= (String)hs.getAttribute("password");
        String url= (String)hs.getAttribute("url");
        String mbase= (String)hs.getAttribute("base");
        String dn="";
        if(mail!=null)
        {
        String arr[]=mail.split("@");
        dn=arr[1];
        }
		String chk=GetUsersList.getUsersListMem(url,username,password,mbase,dn,"mail",mail,"");
		String delarr[]=chk.split(",");
		int f=0;
		for(int j=1;j<delarr.length ;j++)
		{
		if(lstid.equalsIgnoreCase(delarr[j]))
			{
			continue;
			}
		f++;
		if(f==1)
			{
			ModifyAtt.modyfyAtt(hs, mail, dn, "memberOfGroup", delarr[j]);
			}
		else
		{
			ModifyAddAtt.modyfyAddAtt(hs, mail, dn, "memberOfGroup", delarr[j]);
		}
			
		}
		if(f==0)
		{
			ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "memberOfGroup");
		}
		return flg;
	}
}
