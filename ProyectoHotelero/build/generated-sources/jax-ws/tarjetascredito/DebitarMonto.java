
package tarjetascredito;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.ws.Action;
import javax.xml.ws.RequestWrapper;
import javax.xml.ws.ResponseWrapper;


/**
 * This class was generated by the JAX-WS RI.
 * JAX-WS RI 2.2.6-1b01 
 * Generated source version: 2.2
 * 
 */
@WebService(name = "debitarMonto", targetNamespace = "http://TarjetasCredito/")
@XmlSeeAlso({
    ObjectFactory.class
})
public interface DebitarMonto {


    /**
     * 
     * @param monto
     * @param numerotarjeta
     * @return
     *     returns boolean
     */
    @WebMethod
    @WebResult(targetNamespace = "")
    @RequestWrapper(localName = "dibitarMonto", targetNamespace = "http://TarjetasCredito/", className = "tarjetascredito.DibitarMonto")
    @ResponseWrapper(localName = "dibitarMontoResponse", targetNamespace = "http://TarjetasCredito/", className = "tarjetascredito.DibitarMontoResponse")
    @Action(input = "http://TarjetasCredito/debitarMonto/dibitarMontoRequest", output = "http://TarjetasCredito/debitarMonto/dibitarMontoResponse")
    public boolean dibitarMonto(
        @WebParam(name = "numerotarjeta", targetNamespace = "")
        String numerotarjeta,
        @WebParam(name = "monto", targetNamespace = "")
        String monto);

}
