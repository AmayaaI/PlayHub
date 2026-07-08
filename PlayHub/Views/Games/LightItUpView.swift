import SwiftUI

struct LightItUpView: View {

    @StateObject private var vm = LightItUpVM()

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [
                    Color.black,
                    Color.blue.opacity(0.5)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()


            VStack(spacing: 18) {


                // Title

                Text("💡 Light It Up")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)



                // Score panel

                HStack(spacing: 15) {


                    scoreBox(
                        title: "Score",
                        value: "\(vm.score)",
                        icon: "star.fill"
                    )


                    scoreBox(
                        title: "Best",
                        value: "\(vm.highScore)",
                        icon: "trophy.fill"
                    )


                    scoreBox(
                        title: "Time",
                        value: "\(vm.timeRemaining)",
                        icon: "timer"
                    )

                }



                // Level

                Text(vm.level.title)
                    .font(.title2)
                    .bold()
                    .foregroundColor(levelColor())


                Spacer()
                    .frame(height: 10)



                // Grid

                LazyVGrid(

                    columns: Array(
                        repeating:
                            GridItem(.flexible(), spacing: 12),
                        count: vm.level.columns
                    ),

                    spacing: 12

                ) {


                    ForEach(vm.cards) { card in


                        RoundedRectangle(
                            cornerRadius: 18
                        )

                        .fill(

                            card.isLit
                            ?
                            Color.yellow
                            :
                            Color.white.opacity(0.15)

                        )


                        .frame(height: 85)


                        .overlay {

                            Image(systemName: "lightbulb.fill")

                                .font(.title)

                                .foregroundColor(
                                    card.isLit
                                    ?
                                    .white
                                    :
                                    .gray
                                )

                        }


                        .scaleEffect(
                            card.isLit ? 1.12 : 1
                        )


                        .shadow(

                            color:
                                card.isLit
                                ?
                                .yellow
                                :
                                .clear,

                            radius:
                                card.isLit
                                ?
                                20
                                :
                                0

                        )


                        .animation(
                            .easeInOut(duration:0.2),
                            value: card.isLit
                        )


                        .onTapGesture {


                            if let index =
                                vm.cards.firstIndex(
                                    where: {
                                        $0.id == card.id
                                    }
                                ) {


                                vm.tapCard(
                                    at:index
                                )

                            }

                        }


                    }


                }


                Spacer()



                // Start Button

                Button {


                    vm.startGame()


                } label: {


                    HStack {


                        Image(systemName:"play.fill")


                        Text("START GAME")

                            .bold()


                    }


                    .font(.headline)

                    .foregroundColor(.white)

                    .frame(
                        maxWidth:.infinity
                    )

                    .padding()

                    .background(
                        LinearGradient(
                            colors:[
                                .blue,
                                .purple
                            ],
                            startPoint:.leading,
                            endPoint:.trailing
                        )
                    )

                    .cornerRadius(18)


                }

            }

            .padding()

        }


        .overlay {


            if vm.showLevelFlash {


                Color.white
                    .opacity(0.3)
                    .ignoresSafeArea()


            }


        }

        .navigationTitle("")

    }



    // MARK: Score Card

    func scoreBox(
        title:String,
        value:String,
        icon:String
    ) -> some View {


        VStack(spacing:5) {


            Image(systemName:icon)
                .foregroundColor(.yellow)


            Text(value)

                .font(.title3)
                .bold()
                .foregroundColor(.white)


            Text(title)

                .font(.caption)
                .foregroundColor(.white.opacity(0.7))


        }

        .frame(
            width:90,
            height:75
        )

        .background(
            Color.white.opacity(0.15)
        )

        .cornerRadius(15)


    }




    func levelColor() -> Color {


        switch vm.level {


        case .level1:
            return .yellow


        case .level2:
            return .green


        case .level3:
            return .orange


        case .level4:
            return .red


        }


    }


}



#Preview {

    NavigationStack {

        LightItUpView()

    }

}


 

