import { useState } from "react"

export default function App() {
  const [email, setEmail] = useState("")
  const [status, setStatus] = useState<"idle" | "sending" | "success" | "error">("idle")

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setStatus("sending")

    try {
      const res = await fetch("https://nocodeform.io/f/6813b4ad4f95adce939bcd53", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({ email })
      })

      if (res.ok) {
        setStatus("success")
        setEmail("")
      } else {
        setStatus("error")
      }
    } catch {
      setStatus("error")
    }
  }

  return (
    <div className="min-h-screen bg-white text-gray-900 flex flex-col justify-between px-6 py-12">
      <div className="flex-grow flex items-center justify-center">
        <div className="max-w-6xl w-full grid md:grid-cols-2 gap-12 items-center">
          {/* LEFT SIDE */}
          <div>
            <h1 className="text-4xl md:text-5xl font-extrabold mb-4 leading-tight">
              Diversity <span className="text-indigo-600">In Tech</span>
            </h1>

            <p className="text-gray-700 mb-6">
              Explore and rate tech companies on their commitment to diversity and inclusion.
            </p>

            <form onSubmit={handleSubmit} className="flex flex-col md:flex-row items-center gap-2 mb-3">
              <input
                type="email"
                placeholder="Email address"
                className="bg-white text-gray-900 border border-gray-300 px-4 py-2 rounded w-full max-w-sm shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
              />
              <button
                type="submit"
                className="bg-indigo-600 hover:bg-indigo-700 text-white px-6 py-2 rounded font-semibold transition"
                disabled={status === "sending"}
              >
                {status === "sending" ? "Sending..." : "Join waitlist"}
              </button>
            </form>

            {status === "success" && (
              <p className="text-green-600 text-sm">Thanks! You're on the list 🚀</p>
            )}
            {status === "error" && (
              <p className="text-red-500 text-sm">Something went wrong. Try again.</p>
            )}
          </div>

          {/* RIGHT SIDE */}
          <div className="hidden md:block">
            <img src="/logo.svg" alt="App Logo" className="w-full max-w-md mx-auto" />
          </div>
        </div>
      </div>

      {/* Footer */}
      <footer className="mt-12 text-center text-sm text-gray-500">
        Made with 💜 by{" "}
        <a
          href="https://dreamingecho.es"
          className="text-indigo-600 hover:underline"
          target="_blank"
          rel="noopener noreferrer"
        >
          dreamingechoes
        </a>
      </footer>
    </div>
  )
}
