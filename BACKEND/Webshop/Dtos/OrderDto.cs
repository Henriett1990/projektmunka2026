namespace Webshop.Dtos
{
    public class OrderItemDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Price { get; set; }
        public int Quantity { get; set; }
    }

    public class OrderDto
    {
        public List<OrderItemDto> Items { get; set; }
    }
}
