
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

    private final static QName _DibitarMontoResponse_QNAME = new QName("http://TarjetasCredito/", "dibitarMontoResponse");
    private final static QName _DibitarMonto_QNAME = new QName("http://TarjetasCredito/", "dibitarMonto");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: tarjetascredito
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link DibitarMonto }
     * 
     */
    public DibitarMonto createDibitarMonto() {
        return new DibitarMonto();
    }

    /**
     * Create an instance of {@link DibitarMontoResponse }
     * 
     */
    public DibitarMontoResponse createDibitarMontoResponse() {
        return new DibitarMontoResponse();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link DibitarMontoResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://TarjetasCredito/", name = "dibitarMontoResponse")
    public JAXBElement<DibitarMontoResponse> createDibitarMontoResponse(DibitarMontoResponse value) {
        return new JAXBElement<DibitarMontoResponse>(_DibitarMontoResponse_QNAME, DibitarMontoResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link DibitarMonto }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://TarjetasCredito/", name = "dibitarMonto")
    public JAXBElement<DibitarMonto> createDibitarMonto(DibitarMonto value) {
        return new JAXBElement<DibitarMonto>(_DibitarMonto_QNAME, DibitarMonto.class, null, value);
    }

}
