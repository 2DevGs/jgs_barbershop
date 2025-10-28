import 'package:flutter/material.dart';
import 'package:jgs_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:jgs_barbershop/src/core/ui/constants.dart';
import 'package:jgs_barbershop/src/features/home/adm/widgets/home_employee_tile.dart';
import 'package:jgs_barbershop/src/features/home/widgets/home_header.dart';

class HomeAdmPage extends StatelessWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorsConstants.brow,
        onPressed: () {},
        child: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 16,
          child: Icon(BarbershopIcons.addEmployee, color: ColorsConstants.brow),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: HomeHeader()),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const HomeEmployeeTile(),
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
