﻿using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace DnD
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HtmlButton SignUp = new HtmlButton();
            SignUp.ID = "SignupButton";
            SignUp.InnerHtml = "Register!";
            SignUp.ServerClick += new System.EventHandler(this.SignUp_Click);
            Signin.Controls.Add(SignUp);
        }

        void SignUp_Click(object sender, EventArgs e)
        {
            SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();

            builder.DataSource = "hrpsvr.database.windows.net";
            builder.UserID = "hrpzip";
            builder.Password = "DBMProject1!";
            builder.InitialCatalog = "DnD";
            using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
            {

                string Username = TextBoxUsername.Text;
                string Password = TextBoxPassword.Text;
                string PasswordConfirm = TextBoxPasswordConfirm.Text;
                if (Password != PasswordConfirm)
                {
                    Label6.Text = "Passwords don't match.";
                }
                else
                {
                    string userExists = "SELECT * FROM UserInfo WHERE username='" + Username + "'";
                    string myQuery = "INSERT INTO UserInfo(username, password) " +
                        "VALUES('" + Username + "', '" + Password + "')";
                    SqlCommand cmd = new SqlCommand(userExists, connection);
                    SqlCommand command = new SqlCommand(myQuery, connection);
                    connection.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        if (sdr.Read())
                        {
                            Label4.Text = "User already exists!";
                            connection.Close();
                        }
                        else
                        {
                            connection.Close();
                            connection.Open();
                            Label3.Text = " ";
                            command.ExecuteNonQuery();
                            Label3.Text = "Account Created!";
                            connection.Close();
                        }
                    }
                }

            }
        }
    }
}