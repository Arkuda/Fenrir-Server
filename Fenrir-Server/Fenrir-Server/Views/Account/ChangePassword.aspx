﻿<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Fenrir_Server.Models.ChangePasswordModel>" %>

<asp:Content ID="changePasswordTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Смена пароля
</asp:Content>

<asp:Content ID="changePasswordContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Смена пароля</h2>
    <p>
        Используйте следующую форму для смены своего пароля. 
    </p>
    <p>
        Длина нового пароля не должна быть меньше <%: Membership.MinRequiredPasswordLength %> символов.
    </p>

    <script src="<%: Url.Content("~/Scripts/jquery.validate.min.js") %>" type="text/javascript"></script>
    <script src="<%: Url.Content("~/Scripts/jquery.validate.unobtrusive.min.js") %>" type="text/javascript"></script>

    <% using (Html.BeginForm()) { %>
        <%: Html.ValidationSummary(true, "Не удалось изменить пароль. Исправьте ошибки и повторите попытку.") %>
        <div>
            <fieldset>
                <legend>Сведения учетной записи</legend>
                
                <div class="editor-label">
                    <%: Html.LabelFor(m => m.OldPassword) %>
                </div>
                <div class="editor-field">
                    <%: Html.PasswordFor(m => m.OldPassword) %>
                    <%: Html.ValidationMessageFor(m => m.OldPassword) %>
                </div>
                
                <div class="editor-label">
                    <%: Html.LabelFor(m => m.NewPassword) %>
                </div>
                <div class="editor-field">
                    <%: Html.PasswordFor(m => m.NewPassword) %>
                    <%: Html.ValidationMessageFor(m => m.NewPassword) %>
                </div>
                
                <div class="editor-label">
                    <%: Html.LabelFor(m => m.ConfirmPassword) %>
                </div>
                <div class="editor-field">
                    <%: Html.PasswordFor(m => m.ConfirmPassword) %>
                    <%: Html.ValidationMessageFor(m => m.ConfirmPassword) %>
                </div>
                
                <p>
                    <input type="submit" value="Смена пароля" />
                </p>
            </fieldset>
        </div>
    <% } %>
</asp:Content>
