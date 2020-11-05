using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Diagnostics;
using System.Web.Services.Description;
using System.Configuration;
using System.Text;
using System.Xml.Linq;

namespace DnD
{
    public partial class MainPage : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            HtmlButton SubmitButton = new HtmlButton
            {
                ID = "Submitter",
                InnerHtml = "Submit"
            };
            SubmitButton.Attributes.Add("style", "float: left;");
            SubmitButton.ServerClick += new EventHandler(SubmitButton_Click);
            ControlContainer.Controls.Add(SubmitButton);
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        void SubmitButton_Click(Object sender, EventArgs e)
        {
            string textFromForm = ClassChoice.Text;
            Debug.WriteLine(textFromForm);
            Output.Controls.Add(new LiteralControl("<textarea name=\"result2\" value= \"" + textFromForm + "\">" + textFromForm + "</textarea><br />"));
            //< iframe name = "result2" style = "height:100px;width:200px;" ></ iframe >
        }
    }
}