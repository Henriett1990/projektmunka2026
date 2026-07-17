namespace Webshop.Dtos
{
    public class ProductDto
    {
        public string Category { get; set; }
        public string Name { get; set; }
        public string Unit { get; set; }
        public int Price { get; set; }
        public string Description { get; set; }
        public string? Image { get; set; }
        public int Stock { get; set; }   

    }
}
