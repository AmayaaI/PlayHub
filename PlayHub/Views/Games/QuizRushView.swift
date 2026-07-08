
import SwiftUI

struct QuizRushView: View {

    @StateObject private var vm = QuizRushVM()

    var body: some View {

        ZStack {
            background

            content
        }
        .task {
            await vm.load()
        }
    }

    @ViewBuilder
    var content: some View {

        switch vm.state {

        case .loading:
            ProgressView("Loading...")

        case .failed(let msg):
            VStack {
                Text(msg)
                    .foregroundColor(.red)

                Button("Retry") {
                    Task { await vm.retry() }
                }
            }

        case .loaded:
            if let q = vm.currentQuestion {
                questionView(q)
            }

//        case .finished:
//            VStack {
//                Text("Finished")
//                    .font(.largeTitle)
//
//                Text("Score: \(vm.score)")
//                    .font(.title)
//
//                Button("Play Again") {
//                    Task { await vm.load() }
//                }
//            }
        case .finished:

            VStack(spacing:20) {

                Text("🎉 Quiz Complete!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)


                Text("Score: \(vm.score)")
                    .font(.title)


                Text("Best Score: \(vm.highScore)")
                    .font(.headline)
                    .foregroundColor(.yellow)



                Button {

                    Task {
                        await vm.load()
                    }

                } label: {

                    Text("Play Again")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth:.infinity)
                        .background(Color.green)
                        .cornerRadius(15)

                }

            }
            .padding()
        }
    }

    func questionView(_ q: TriviaQuestion) -> some View {

        VStack(spacing: 20) {

            //Text("Score: \(vm.score) | Streak: \(vm.streak)")

            HStack {

                Text("⭐ \(vm.score)")
                
                Spacer()

                Text("🔥 \(vm.streak)")

                Spacer()

                Text("🏆 \(vm.highScore)")

            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.black.opacity(0.3))
            )
            
            Text(q.question)
                .multilineTextAlignment(.center)

            ForEach(q.allAnswers, id: \.self) { ans in
                Button {
                    vm.answer(ans)
                }label: {
                    Text(ans)
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue.opacity(0.8))
                        )
                }
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(Color.blue.opacity(0.2))
//                .cornerRadius(10)
            }

            Text("Question \(vm.index + 1)/10")
        }
        .padding()
    }

    var background: some View {
        LinearGradient(
            colors: [.purple, .blue],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}
#Preview {

    NavigationStack {

        QuizRushView()

    }

}
