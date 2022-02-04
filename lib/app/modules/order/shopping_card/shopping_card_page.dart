import 'package:dart_week_vakinha_burger/app/core/ui/formatter_helper.dart';
import 'package:dart_week_vakinha_burger/app/core/ui/widgets/plus_minus_box.dart';
import 'package:dart_week_vakinha_burger/app/core/ui/widgets/vakinha_button.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import './shopping_card_controller.dart';

class ShoppingCardPage extends GetView<ShoppingCardController> {
  
  ShoppingCardPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShoppingCardPage'),
      ),
      body: LayoutBuilder(builder: (_, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight, 
              minWidth: constraints.maxWidth
            ),
            child: IntrinsicHeight(
              child: Visibility(
                visible: controller.products.isNotEmpty,
                replacement: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Carrinho',
                        style: context.textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.theme.primaryColor
                        ),
                      ),
                      const SizedBox(
                         height: 10,
                      ),
                      const Text("Nenhum item adicionado no carrinho")
                    ],
                  ),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              'Carrinho',
                              style: context.textTheme.headline6?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.theme.primaryColor
                              ),
                            ),
                            IconButton(
                              onPressed: controller.clear,
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              )
                            ),
                          ],
                        ),
                      ),
                      Obx(() => Column(
                        children: controller.products.map((e) => Container(
                          margin: const EdgeInsets.all(10),
                          child: PlusMinusBox(
                            label: e.product.name,
                            calculateTotal: true,
                            elevated: true,
                            backgroundColor: Colors.white,
                            quantity: e.quantity,
                            price: e.product.price,
                            minusCallback: () => controller.subtractQuantityInProduct(e),
                            plusCallback: () => controller.addQuantityInProduct(e),
                          ),
                        )).toList(),
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total do pedido",
                              style: context.textTheme.bodyText1
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Obx(() => Text(
                              FormatterHelper.formatCurrency(controller.totalValue),
                              style: context.textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.bold
                              ),
                            )),
                          ],
                        ),
                      ),
                      const Divider(),
                      const _AddressField(),
                      const Divider(),
                      const _CpfField(),
                      const Divider(),
                      const Spacer(),
                      Center(
                        child: SizedBox(
                          width: context.widthTransformer(reducedBy: 10),
                          child: VakinhaButton(
                            label: "FINALIZAR",
                            onPressed: () async {

                              final formValid = formKey.currentState?.validate() ?? false;

                              if(formValid) {
                                await controller.createOrder();
                              }
                            }
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _AddressField extends GetView<ShoppingCardController> {
  const _AddressField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 35,
            child: Expanded(
              child: Text(
                'Endereço de entrega',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) => controller.address = value,
            validator: Validatorless.required("Endereço obrigatório"),
            decoration: const InputDecoration(
                hintText: "Digite o endereço",
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class _CpfField extends GetView<ShoppingCardController> {
  const _CpfField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 35,
            child: Expanded(
              child: Text(
                'CPF',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) => controller.cpf = value,
            validator: Validatorless.multiple([
              Validatorless.required("CPF obrigatório"),
              Validatorless.cpf("CPF inválido")
            ]),
            decoration: const InputDecoration(
                hintText: "Digite o CPF",
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}