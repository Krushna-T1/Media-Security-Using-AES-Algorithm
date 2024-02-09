
package CryptoException;
public class CryptoException extends Exception {

	private static final long serialVersionUID = 12002L;

	public CryptoException() {
    }
  
    public CryptoException(String message, Throwable throwable) {
      super(message, throwable);
    }
  }
  