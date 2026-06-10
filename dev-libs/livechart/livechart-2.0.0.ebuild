# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

DESCRIPTION="Live charting library used by elementary projects"
HOMEPAGE="https://github.com/elementary/live-chart"
SRC_URI="https://github.com/elementary/live-chart/archive/${PV}.tar.gz -> ${P}.tar.gz"

S=${WORKDIR}/live-chart-${PV}

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	$(vala_depend)
	gui-libs/gtk:4
	dev-libs/libgee:0.8
	dev-libs/glib:2
	virtual/pkgconfig
	sys-devel/gettext
	dev-build/meson
	dev-build/ninja
	x11-misc/xvfb-run
"

RDEPEND="
	dev-libs/glib:2
	gui-libs/gtk:4
	dev-libs/libgee:0.8
"

src_prepare() {
	eapply_user
	vala_setup
}
