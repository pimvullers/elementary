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

RDEPEND="
	dev-libs/glib:2
	gui-libs/gtk:4
	dev-libs/libgee:0.8
"
DEPEND="
	$(vala_depend)
	${RDEPEND}
"

src_prepare() {
	eapply_user
	sed -i '/tests/d' meson.build
	vala_setup
}
