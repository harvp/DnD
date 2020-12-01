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
using System.Data.SqlClient;
using System.Data;

namespace DnD
{
    public partial class DisplayCharacter : System.Web.UI.Page
    {
        SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder
        {
            DataSource = "hrpsvr.database.windows.net",
            UserID = "hrpzip",
            Password = "DBMProject1!",
            InitialCatalog = "DnD"
        };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder
                {
                    DataSource = "hrpsvr.database.windows.net",
                    UserID = "hrpzip",
                    Password = "DBMProject1!",
                    InitialCatalog = "DnD"
                };

                using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
                {
                    int userIDNumber = 1;
                    string queryBuild = "SELECT * FROM Character WHERE userID = " + userIDNumber + ";";
                    SqlDataAdapter command = new SqlDataAdapter(queryBuild, connection);
                    connection.Open();

                    DataSet ds = new DataSet();
                    command.Fill(ds, "DeckList");

                    Select1.DataSource = ds;
                    Select1.DataTextField = "name";
                    Select1.DataValueField = "charID";
                    Select1.DataBind();
                }
                
            }
        }
        public void SubmitDisplay(object sender, EventArgs e)
        {
            int userIDNumber = 1;
            string myCharID = Select1.Value.ToString();
            //Display Name
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {
                string queryBuild = "SELECT name FROM Character WHERE charID = " + myCharID + ";";
                SqlCommand command = new SqlCommand(queryBuild, connection);
                command.CommandType = System.Data.CommandType.Text;
                connection.Open();
                string temp = "";

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                   temp += reader["name"].ToString();
                }
                characterName.InnerText = temp;
                temp = "";
                while (reader.Read())
                {
                    temp += reader["player"].ToString();
                }
                playerName.InnerText = temp;
            }

        }
    }
}