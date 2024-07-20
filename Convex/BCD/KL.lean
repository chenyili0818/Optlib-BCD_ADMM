import Convex.Function.Proximal
import Convex.BCD.Subdifferential

open Filter BigOperators Set Topology

noncomputable section

variable {E : Type*}
variable [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
variable {f : E → ℝ} {x : E}

def special_concave (η : ℝ) := {f : ℝ → ℝ | (∀ x ∈ Ico 0 η, f x > 0) ∧ (f 0 = 0) ∧
  (ContDiffOn ℝ 1 f (Ioo 0 η)) ∧ (ContinuousAt f 0) ∧ (∀ x ∈ Ioo 0 η, deriv f x > 0)}

def KL_point (σ : E → ℝ) (u : E) : Prop :=
  ∃ η ∈ Ioi 0, ∃ s ∈ 𝓝 u, ∃ φ ∈ special_concave η, ∀ x ∈ s ∩
  {y ∈ active_domain σ | σ u < σ y ∧ σ y < σ u + η},
  deriv φ (σ x - σ u) * (EMetric.infEdist 0 (subdifferential σ x)).toReal ≥ 1

def KL_function (σ : E → ℝ) : Prop :=
  ∀ u ∈ active_domain σ, KL_point σ u

end