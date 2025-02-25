# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_VERSION=0.22

inherit meson vala

DESCRIPTION="Session indicator for Wingpanel"
HOMEPAGE="https://github.com/elementary/wingpanel-indicator-session"
SRC_URI="https://github.com/elementary/wingpanel-indicator-session/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:0
	pantheon-base/wingpanel
	sys-apps/accountsservice:=
	x11-libs/gtk+:3
"

DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}
