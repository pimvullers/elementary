# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="Mouse and touchpad settings"
HOMEPAGE="https://github.com/elementary/switchboard-plug-mouse-touchpad"
SRC_URI="https://github.com/elementary/switchboard-plug-mouse-touchpad/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:7
	dev-libs/libxml2:2
	pantheon-base/switchboard:3
	gui-libs/gtk:4
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}
