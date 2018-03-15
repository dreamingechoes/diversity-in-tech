defmodule DiversityInTechWeb.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :diversity_in_tech,
    module: DiversityInTech.Guardian,
    error_handler: DiversityInTech.Guardian.AuthErrorHandler

  plug(Guardian.Plug.VerifySession)
  plug(Guardian.Plug.VerifyHeader)
  plug(Guardian.Plug.EnsureAuthenticated)
end
