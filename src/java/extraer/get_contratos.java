package extraer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import programas.bdconexion;

@WebServlet(urlPatterns = {"/extraer/get_contratos"})
public class get_contratos extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            bdconexion cn = new bdconexion();
            try {
                try {
                    cn.crearConexion();
                } catch (Exception ex) {
                    Logger.getLogger(get_contratos.class.getName()).log(Level.SEVERE, null, ex);
                    out.println("<tr><td colspan='8'>Error al conectar con la base de datos: " + ex.getMessage() + "</td></tr>");
                    return;
                }
                
                String sql = request.getParameter("sql");
                if (sql == null || sql.isEmpty()) {
                    out.println("<tr><td colspan='8'>No se ha especificado una consulta SQL</td></tr>");
                    return;
                }
                
                // Detectar si es una consulta de cláusulas
                if (sql.toLowerCase().contains("clausulas cl")) {
                    procesarClausulas(cn, sql, out);
                    return;
                }
                
                // Procesamiento normal de contratos
                ResultSet rs = cn.consultar(sql);
                DecimalFormat df = new DecimalFormat("#,##0.00");
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                
                if (!rs.next()) {
                    out.println("<tr><td colspan='7' class='text-center'>No se encontraron contratos</td></tr>");
                } else {
                    do {
                        out.println("<tr onclick=\"seleccion($(this));\" style=\"cursor: pointer;\">");
                        
                        // ID del contrato
                        out.println("<td>");
                        out.println(rs.getString("con_id"));
                        out.println("</td>");
                        
                        // Cliente
                        out.println("<td>");
                        String cliente = rs.getString("cliente");
                        out.println(cliente != null ? cliente : "N/A");
                        out.println("</td>");
                        
                        // Vendedor
                        out.println("<td>");
                        String vendedor = rs.getString("vendedor");
                        out.println(vendedor != null ? vendedor : "N/A");
                        out.println("</td>");
                        
                        // Vehículo
                        out.println("<td>");
                        String vehiculo = rs.getString("vehiculo");
                        out.println(vehiculo != null ? vehiculo : "N/A");
                        out.println("</td>");
                        
                        // Precio
                        out.println("<td class='text-right'>");
                        try {
                            double precio = rs.getDouble("con_precio");
                            out.println("$" + df.format(precio));
                        } catch (SQLException e) {
                            out.println("$0.00");
                        }
                        out.println("</td>");
                        
                        // Método de pago
                        out.println("<td>");
                        String metodo = rs.getString("con_metodo");
                        out.println(metodo != null ? metodo : "N/A");
                        out.println("</td>");
                        
                        // Fecha
                        out.println("<td>");
                        try {
                            java.sql.Timestamp fecha = rs.getTimestamp("con_fyh");
                            if (fecha != null) {
                                out.println(sdf.format(fecha));
                            } else {
                                out.println("N/A");
                            }
                        } catch (Exception e) {
                            String fechaStr = rs.getString("con_fyh");
                            out.println(fechaStr != null ? fechaStr : "N/A");
                        }
                        out.println("</td>");
                        
                        // Campos ocultos para la selección
                        out.println("<td style=\"display:none;\">");
                        out.println(rs.getString("usu_id"));  // usu_id oculto
                        out.println("</td>");
                        
                        out.println("<td style=\"display:none;\">");
                        out.println(rs.getString("ven_id"));  // ven_id oculto
                        out.println("</td>");
                        
                        out.println("<td style=\"display:none;\">");
                        out.println(rs.getString("cli_id"));  // cli_id oculto
                        out.println("</td>");
                        
                        out.println("<td style=\"display:none;\">");
                        out.println(rs.getString("aut_id"));  // aut_id oculto
                        out.println("</td>");
                        
                        out.println("</tr>");
                    } while (rs.next());
                }
            } catch (SQLException ex) {
                Logger.getLogger(get_contratos.class.getName()).log(Level.SEVERE, null, ex);
                out.println("<tr><td colspan='7'>Error en la consulta: " + ex.getMessage() + "</td></tr>");
            } finally {
                try {
                    cn.cerrarConexion();
                } catch (Exception ex) {
                    Logger.getLogger(get_contratos.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }
    
    private void procesarClausulas(bdconexion cn, String sql, PrintWriter out) {
        try {
            ResultSet rs = cn.consultar(sql);
            
            if (!rs.next()) {
                out.println("<tr><td colspan='3' class='text-center'>No se encontraron cláusulas</td></tr>");
            } else {
                do {
                    out.println("<tr>");
                    
                    // tip_id (oculto, pero necesario para el JavaScript)
                    out.println("<td style=\"display:none;\">");
                    String tipId = rs.getString("tip_id");
                    out.println(tipId != null ? tipId : "");
                    out.println("</td>");
                    
                    // Tipo de cláusula
                    out.println("<td>");
                    String tipDescrip = rs.getString("tip_descrip");
                    out.println(tipDescrip != null ? tipDescrip : "Error");
                    out.println("</td>");
                    
                    // Descripción
                    out.println("<td>");
                    String claDescrip = rs.getString("cla_descrip");
                    out.println(claDescrip != null ? claDescrip : "Error en datos");
                    out.println("</td>");
                    
                    out.println("</tr>");
                } while (rs.next());
            }
        } catch (SQLException ex) {
            Logger.getLogger(get_contratos.class.getName()).log(Level.SEVERE, null, ex);
            out.println("<tr><td colspan='3'>Error en la consulta de cláusulas: " + ex.getMessage() + "</td></tr>");
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
        return "Servlet para obtener datos de contratos y cláusulas - Versión mejorada";
    }
}