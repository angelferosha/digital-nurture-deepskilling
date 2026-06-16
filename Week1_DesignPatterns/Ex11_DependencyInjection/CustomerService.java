public class CustomerService {
    private CustomerRepository customerRepository;

    // Constructor Injection - dependency is "injected" here
    public CustomerService(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    public String getCustomer(int id) {
        return customerRepository.findCustomerById(id);
    }
}
