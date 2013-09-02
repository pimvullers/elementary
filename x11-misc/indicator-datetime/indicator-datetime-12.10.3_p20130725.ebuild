# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2-utils autotools-utils

DESCRIPTION="The Date and Time Indicator - A very, very simple clock"
HOMEPAGE="https://launchpad.net/indicator-datetime"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/indicator-datetime_12.10.3%2B13.10.20130725.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="
	>=app-misc/geoclue-0.12.0
	>=dev-libs/glib-2.35.4:2
	>=dev-libs/libical-0.48
	>=gnome-extra/evolution-data-server-3.5.3
	>=x11-libs/gtk+-3.1.4:3"
DEPEND="${RDEPEND}"

S="${WORKDIR}/indicator-datetime-12.10.3+13.10.20130725"

AUTOTOOLS_AUTORECONF=1

src_prepare() {
	autotools-utils_src_prepare
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
