
package tarjetascredito;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the tarjetascredito package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _ExisteTarjeta_QNAME = new QName("http://TarjetasCredito/", "existeTarjeta");
    private final static QName _ExisteTarjetaResponse_QNAME = new QName("http://TarjetasCredito/", "existeTarjetaResponse");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: tarjetascredito
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link ExisteTarjetaResponse }
     * 
     */
    public ExisteTarjetaResponse createExisteTarjetaResponse() {
        return new ExisteTarjetaResponse();
    }

    /**
     * Create an instance of {@link ExisteTarjeta_Type }
     * 
     */
    public ExisteTarjeta_Type createExisteTarjeta_Type() {
        return new ExisteTarjeta_Type();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ExisteTarjeta_Type }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://TarjetasCredito/", name = "existeTarjeta")
    public JAXBElement<ExisteTarjeta_Type> createExisteTarjeta(ExisteTarjeta_Type value) {
        return new JAXBElement<ExisteTarjeta_Type>(_ExisteTarjeta_QNAME, ExisteTarjeta_Type.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ExisteTarjetaResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://TarjetasCredito/", name = "existeTarjetaResponse")
    public JAXBElement<ExisteTarjetaResponse> createExisteTarjetaResponse(ExisteTarjetaResponse value) {
        return new JAXBElement<ExisteTarjetaResponse>(_ExisteTarjetaResponse_QNAME, ExisteTarjetaResponse.class, null, value);
    }

}
