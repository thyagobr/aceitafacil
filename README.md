# Aceita Fácil

Esta gem habilita as funcionalidades da API do serviço [Aceita Fácil][url] no Ruby on Rails.

## Installation

Adicione esta linha ao seu Gemfile:

    gem 'aceitafacil'

E execute:

    $ bundle

Ou instale assim:

    $ gem install aceitafacil

## Usage

Cadastre os vendedores que receberão os pagamentos da loja em questão da seguinte forma:
    
    @vendor = Aceitafacil::Vendor.new(id: "2", name: "Vendor name", email: "vendor@vendor.com", 
    bank: { 
        code: "001", 
        agency: "123-4", 
        account_type: 1, # 1 Corrent, 2 Poupança
        account_number: "1234-5", 
        account_holder_name: "Fulano",
        account_holder_document_type: 1, # 1 CPF, 2 CNPJ
        account_holder_document_number: "12345678909"
    })

    @vendor.save

O id: refere-se ao ID do vendedor na base de dados da aplicação Host.

Implemente um formulário para capturar os dados do cartão de crédito. Segue um exemplo:

    @card = Aceitafacil::Card.new(name: "Card Holder", number: "4012001038443335", cvv: "123", exp_date: "201807", customer_id: "1")
    @card.save

O customer_id reference ao ID do cliente no banco de dados da aplicação Host.

O método __save__ sincroniza as informações enviadas com o servidor do [Aceita Fácil][url].

Com os dados do cartão de crédito enviados e os vendedores cadastrados você já pode efetuar um pagamento, segue um exemplo:

Recupere a instância de um vendedor na API, Ex:
    
    @vendor = Aceitafacil::Vendor.find(2)

Instancie os items que estão sendo vendidos da seguinte forma:
    
    @item = Aceitafacil::Item.new(amount: 10.0, vendor_id: @vendor.id, vendor_name: @vendor.name, fee_split: 1, description: "Test item", trigger_lock: false)

Recupere as informações do TOKEN do cartão de crédito, Ex:

    @card = Aceitafacil::Card.find_by_customer_id(1)[0]

Faça uma requisição para efetuar o pagamento:

    @payment = Payment.new(description: "Test payment", customer_id: 1, customer_name: "Fulano de Tal", customer_email: "fulano@fulanodetal.com.br", customer_email_language: "pt-BR", paymentmethod_id: 1, total_amount: 10, items: [@item], card: @card)

    @payment.save

Após a chamada do método save todos os métodos abaixo deverão estar preenchidos:
    
    @payment.id
    @payment.organization_id
    @payment.organization_name
    @payment.paymentmethod
    @payment.chargetype
    @payment.payer
    @payment.paid

## Contributing

1. Fork it ( http://github.com/<my-github-username>/aceitafacil/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


[url]: http://www.aceitafacil.com  "Aceita Fácil"