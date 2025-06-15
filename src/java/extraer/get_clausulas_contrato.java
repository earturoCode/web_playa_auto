package extraer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import programas.bdconexion;

@WebServlet(urlPatterns = {"/extraer/get_clausulas_contrato"})
public class get_clausulas_contrato extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String format = request.getParameter("format");
        
        if ("json".equals(format)) {
            // Devolver JSON
            response.setContentType("application/json;charset=UTF-8");
            processJsonRequest(request, response);
        } else {
            // Devolver HTML (por defecto)
            response.setContentType("text/html;charset=UTF-8");
            processHtmlRequest(request, response);
        }
    }
    
    private void processJsonRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try (PrintWriter out = response.getWriter()) {
            bdconexion cn = new bdconexion();
            try {
                try {
                    cn.crearConexion();
                } catch (Exception ex) {
                    Logger.getLogger(get_clausulas_contrato.class.getName()).log(Level.SEVERE, null, ex);
                    out.println("[]");
                    return;
                }
                
                String sql = request.getParameter("sql");
                if (sql == null || sql.isEmpty()) {
                    out.println("[]");
                    return;
                }
                
                ResultSet rs = cn.consultar(sql);
                StringBuilder json = new StringBuilder();
                json.append("[");
                
                boolean primera = true;
                while (rs.next()) {
                    if (!primera) {
                        json.append(",");
                    }
                    primera = false;
                    
                    json.append("{");
                    json.append("\"tip_id\":\"").append(rs.getString("tip_id")).append("\",");
                    
                    String tipDescrip = rs.getString("tip_descrip");
                    if (tipDescrip != null) {
                        tipDescrip = tipDescrip.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
                    } else {
                        tipDescrip = "";
                    }
                    json.append("\"tip_descrip\":\"").append(tipDescrip).append("\",");
                    
                    String claDescrip = rs.getString("cla_descrip");
                    if (claDescrip != null) {
                        claDescrip = claDescrip.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
                    } else {
                        claDescrip = "";
                    }
                    json.append("\"cla_descrip\":\"").append(claDescrip).append("\"");
                    json.append("}");
                }
                
                json.append("]");
                out.print(json.toString());
                
            } catch (SQLException ex) {
                Logger.getLogger(get_clausulas_contrato.class.getName()).log(Level.SEVERE, null, ex);
                out.println("[]");
            } finally {
                try {
                    cn.cerrarConexion();
                } catch (Exception ex) {
                    Logger.getLogger(get_clausulas_contrato.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }
    
    private void processHtmlRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try (PrintWriter out = response.getWriter()) {
            bdconexion cn = new bdconexion();
            try {
                try {
                    cn.crearConexion();
                } catch (Exception ex) {
                    Logger.getLogger(get_clausulas_contrato.class.getName()).log(Level.SEVERE, null, ex);
                    out.println("<tr><td colspan='3'>Error al conectar con la base de datos: " + ex.getMessage() + "</td></tr>");
                    return;
                }
                
                String sql = request.getParameter("sql");
                if (sql == null || sql.isEmpty()) {
                    out.println("<tr><td colspan='3'>No se ha especificado una consulta SQL</td></tr>");
                    return;
                }
                
                ResultSet rs = cn.consultar(sql);
                
                if (!rs.next()) {
                    out.println("<tr><td colspan='3' class='text-center'>No se encontraron cláusulas</td></tr>");
                } else {
                    do {
                        out.println("<tr>");
                        
                        // tip_id (oculto, pero necesario para el JavaScript)
                        out.println("<td style=\"display:none;\">");
                        out.println(rs.getString("tip_id"));
                        out.println("</td>");
                        
                        // Tipo de cláusula
                        out.println("<td>");
                        out.println(rs.getString("tip_descrip"));
                        out.println("</td>");
                        
                        // Descripción
                        out.println("<td>");
                        out.println(rs.getString("cla_descrip"));
                        out.println("</td>");
                        
                        out.println("</tr>");
                    } while (rs.next());
                }
            } catch (SQLException ex) {
                Logger.getLogger(get_clausulas_contrato.class.getName()).log(Level.SEVERE, null, ex);
                out.println("<tr><td colspan='3'>Error en la consulta: " + ex.getMessage() + "</td></tr>");
            } finally {
                try {
                    cn.cerrarConexion();
                } catch (Exception ex) {
                    Logger.getLogger(get_clausulas_contrato.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para obtener cláusulas de un contrato específico";
    }
}